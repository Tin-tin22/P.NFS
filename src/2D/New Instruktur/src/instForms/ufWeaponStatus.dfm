object fWeaponStatus: TfWeaponStatus
  Left = 0
  Top = 0
  Width = 398
  Height = 963
  TabOrder = 0
  object pnlWeaponStatus: TPanel
    Left = 0
    Top = 0
    Width = 398
    Height = 963
    Align = alClient
    BevelOuter = bvNone
    Color = 7301478
    TabOrder = 0
    object rzgrpWeaponStatus: TRzGroupBar
      Left = 0
      Top = 0
      Width = 397
      Height = 963
      BorderColor = 7301478
      BorderShadow = 7301478
      GradientColorStart = 7301478
      GradientColorStop = 7301478
      FlatColor = 7301478
      Style = gbsOutlook
      GroupBorderSize = 0
      Color = clBtnShadow
      ParentColor = False
      TabOrder = 0
      object rzgrpStrela: TRzGroup
        CaptionFont.Charset = DEFAULT_CHARSET
        CaptionFont.Color = clGreen
        CaptionFont.Height = -11
        CaptionFont.Name = 'MS Sans Serif'
        CaptionFont.Style = [fsBold]
        CaptionHotColor = clBlack
        Color = clGray
        ColorDefault = False
        Items = <>
        ItemHotColor = clDefault
        Opened = False
        OpenedHeight = 842
        DividerVisible = False
        Caption = 'STRELA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clInfoText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Visible = False
        object scrlbxStrela: TScrollBox
          Left = 0
          Top = 20
          Width = 397
          Height = 0
          Align = alClient
          Color = clGray
          ParentColor = False
          TabOrder = 0
          object Label2: TLabel
            Left = 166
            Top = 11
            Width = 62
            Height = 19
            Caption = 'STRELA'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -16
            Font.Name = 'Times New Roman'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Bevel3: TBevel
            Left = 45
            Top = 41
            Width = 268
            Height = 1
          end
          object grp19: TGroupBox
            Left = 43
            Top = 48
            Width = 270
            Height = 377
            Caption = 'Status Launcher'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object grpRightLauncherStrela: TGroupBox
              Left = 45
              Top = 191
              Width = 181
              Height = 156
              Caption = 'StarBoard'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              object imgLoadRightStr1: TImage
                Left = 34
                Top = 25
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgLoadStrRight2: TImage
                Left = 33
                Top = 70
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgLoadStrRight3: TImage
                Left = 119
                Top = 23
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgLoadStrRight4: TImage
                Left = 119
                Top = 69
                Width = 17
                Height = 17
                Transparent = True
              end
              object lbl105: TLabel
                Left = 17
                Top = 25
                Width = 8
                Height = 13
                Caption = '1'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lbl106: TLabel
                Left = 17
                Top = 71
                Width = 8
                Height = 13
                Caption = '2'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lbl107: TLabel
                Left = 103
                Top = 24
                Width = 8
                Height = 13
                Caption = '3'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lbl108: TLabel
                Left = 103
                Top = 70
                Width = 8
                Height = 13
                Caption = '4'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object btn1: TButton
                Left = 79
                Top = 118
                Width = 79
                Height = 21
                Caption = 'Load'
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
                OnClick = btnStrelaLoadingClick
              end
              object cbbLoadStrellaStarboard: TComboBox
                Left = 18
                Top = 118
                Width = 46
                Height = 21
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 1
                Text = '1'
                Items.Strings = (
                  '1'
                  '2'
                  '3'
                  '4'
                  'All')
              end
            end
            object grpLeftLauncherStrela: TGroupBox
              Left = 46
              Top = 26
              Width = 181
              Height = 156
              Caption = 'Port'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              object imgLoadStrLeft1: TImage
                Left = 34
                Top = 22
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgLoadStrLeft2: TImage
                Left = 34
                Top = 71
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgLoadStrLeft3: TImage
                Left = 122
                Top = 23
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgLoadStrLeft4: TImage
                Left = 122
                Top = 72
                Width = 17
                Height = 17
                Transparent = True
              end
              object lbl109: TLabel
                Left = 18
                Top = 23
                Width = 8
                Height = 13
                Caption = '1'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lbl110: TLabel
                Left = 18
                Top = 72
                Width = 8
                Height = 13
                Caption = '2'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lbl111: TLabel
                Left = 106
                Top = 25
                Width = 8
                Height = 13
                Caption = '3'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lbl112: TLabel
                Left = 106
                Top = 73
                Width = 8
                Height = 13
                Caption = '4'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object btn6: TButton
                Tag = 1
                Left = 80
                Top = 115
                Width = 79
                Height = 21
                Caption = 'Load'
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
                OnClick = btnStrelaLoadingClick
              end
              object cbbLoadStrellaPort: TComboBox
                Left = 18
                Top = 115
                Width = 46
                Height = 21
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 1
                Text = '1'
                Items.Strings = (
                  '1'
                  '2'
                  '3'
                  '4'
                  'All')
              end
            end
          end
          object grp20: TGroupBox
            Left = 45
            Top = 432
            Width = 269
            Height = 65
            Caption = 'Status Console'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            object chk11: TCheckBox
              Left = 17
              Top = 24
              Width = 97
              Height = 17
              Caption = 'Port'
              TabOrder = 0
            end
            object chk12: TCheckBox
              Left = 166
              Top = 24
              Width = 97
              Height = 17
              Caption = 'StarBoard'
              TabOrder = 1
            end
          end
        end
      end
      object rzgrpTetral: TRzGroup
        CaptionFont.Charset = DEFAULT_CHARSET
        CaptionFont.Color = clWindowText
        CaptionFont.Height = -11
        CaptionFont.Name = 'MS Sans Serif'
        CaptionFont.Style = [fsBold]
        Color = clGray
        ColorDefault = False
        Items = <>
        Opened = False
        OpenedHeight = 842
        DividerVisible = False
        Caption = 'TETRAL'
        ParentColor = False
        Visible = False
        object scrlbxTetral: TScrollBox
          Left = 0
          Top = 20
          Width = 397
          Height = 0
          Align = alClient
          Color = clGray
          ParentColor = False
          TabOrder = 0
          object Label3: TLabel
            Left = 159
            Top = 11
            Width = 63
            Height = 19
            Caption = 'TETRAL'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -16
            Font.Name = 'Times New Roman'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Bevel4: TBevel
            Left = 45
            Top = 41
            Width = 268
            Height = 1
          end
          object grpTetral: TGroupBox
            Left = 44
            Top = 572
            Width = 268
            Height = 105
            Caption = 'AssignTetral'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object btnTetralTrack: TSpeedButton
              Left = 198
              Top = 27
              Width = 27
              Height = 22
              Glyph.Data = {
                36090000424D360900000000000036000000280000001F000000180000000100
                18000000000000090000000000000000000000000000000000006161613E3E3E
                3737374040403B3B3B3A3A3A4141414141413A3A3A3A3A3A4040403737373E3E
                3E3D3D3D3838384141413A3A3A3B3B3B4040403737373E3E3E3D3D3D38383841
                41413A3A3A3B3B3B4040403737373E3E3E3C3C3C383838000000B2B2B27C7C7C
                7474747F7F7F7878787777778080808080807878787878788080807474747C7C
                7C7B7B7B7474748080807A7A7A7A7A7A7F7F7F7474747C7C7C7B7B7B74747480
                80807777777979797F7F7F7474747D7D7D7A7A7A757575000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2BDBDBDBBBBBBB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2C0C0C04949
                491111111111111111111212121212121A1A1AB2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B29191914D4D4D5454545F5F
                5F6565656262620000004747476565656363634D4D4D4D4D4D797979BABABAB2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B29797976969692929292929298686
                86B2B2B2ADADAD0000007D7D7DB2B2B2ABABAB292929292929545454979797B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B23D3D3D3B3B3BB2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B26A6A6A0E0E0EB2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B21616166F6F6FA5A5A5B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2AAAAAA94949413
                13138A8A8AB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2030303757575B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2A4A4A400
                0000868686B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2A6A6A68B8B8B2C2C2C838383B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007F7F7FB4B4B4B2B2B2B2B2B2B2B2B2B2B2B2A7A7A727
                27277272729C9C9CB2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000BDBDBDB7B7B7B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD000000888888BBBBBBB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B22C2C2C4C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000B0B0B0B3B3B3B2B2B2B2B2B2BFBFBFB6B6
                B6B2B2B2B1B1B19D9D9DADADADB3B3B3B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3BF
                BFBF3030304C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B0000004F4F4F5151515151515151515858585353
                53737373B2B2B2B2B2B2B2B2B28D8D8D51515151515151515151515152525258
                58581616164C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B0000002424242525252525252525252525252525
                25575757B2B2B2B2B2B2B2B2B27D7D7D25252525252525252525252525252525
                25250909094C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000AFAFAFB2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B22C2C2C4C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000BBBBBBB6B6B6B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD171717848484B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B22C2C2C4C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B29999995F5F5F5A5A5A949494B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B5B5B5B2B2B253
                53535C5C5C828282B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2030303757575B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B7B7B7AFAFAF00
                0000868686B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2030303757575B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2A4A4A400
                0000868686B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B29A9A9A4545454B4B4BB2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B274747423232399
                9999ACACACB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B27A7A7A5A5A5A5555555555559494
                94B5B5B5B4B4B4000000838383B7B7B7ADADAD555555555555585858646464B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B28282822121212121216D6D
                6D9595959898980000006E6E6E9898988B8B8B2121212121215B5B5BB2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B23939
                39000000000000000000000000000000090909B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2A0A0
                A0979797979797979797979797979797999999B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000}
            end
            object edtTetralTrack: TEdit
              Left = 11
              Top = 26
              Width = 180
              Height = 21
              TabOrder = 0
            end
            object btnTetralAssign: TButton
              Tag = 1
              Left = 11
              Top = 61
              Width = 88
              Height = 25
              Caption = 'Assign'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
            end
            object btnTetralDeAssign: TButton
              Tag = 2
              Left = 107
              Top = 61
              Width = 83
              Height = 25
              Caption = 'Cancel'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
            end
          end
          object grp15: TGroupBox
            Left = 46
            Top = 464
            Width = 266
            Height = 81
            Caption = 'Status Launcher'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            object chkTetralFwd: TCheckBox
              Tag = 601
              Left = 14
              Top = 21
              Width = 137
              Height = 17
              Caption = 'Tetral Fwd'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
            end
            object chkTetralAft: TCheckBox
              Tag = 602
              Left = 14
              Top = 48
              Width = 137
              Height = 17
              Caption = 'Tetral Aft'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
            end
          end
          object grp16: TGroupBox
            Left = 47
            Top = 48
            Width = 265
            Height = 393
            Caption = 'Status Launcher'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            object grpLauncher1Tetral: TGroupBox
              Left = 41
              Top = 19
              Width = 179
              Height = 171
              Caption = 'FWD Launcher'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              object imgLoadFWDTet1: TImage
                Left = 33
                Top = 30
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgLoadFWDTet2: TImage
                Left = 33
                Top = 80
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgLoadFWDTet3: TImage
                Left = 110
                Top = 28
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgLoadFWDTet4: TImage
                Left = 110
                Top = 78
                Width = 17
                Height = 17
                Transparent = True
              end
              object lbl93: TLabel
                Left = 17
                Top = 30
                Width = 8
                Height = 13
                Caption = '1'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lbl94: TLabel
                Left = 17
                Top = 82
                Width = 8
                Height = 13
                Caption = '2'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lbl95: TLabel
                Left = 94
                Top = 28
                Width = 8
                Height = 13
                Caption = '3'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lbl96: TLabel
                Left = 94
                Top = 79
                Width = 8
                Height = 13
                Caption = '4'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object btnTetralLoading4: TButton
                Left = 76
                Top = 135
                Width = 81
                Height = 22
                Caption = 'Load'
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
                OnClick = btnTetralLoadingClick
              end
              object cbbLoadTetralFWD: TComboBox
                Left = 19
                Top = 135
                Width = 46
                Height = 21
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 1
                Text = '1'
                Items.Strings = (
                  '1'
                  '2'
                  '3'
                  '4'
                  'All')
              end
            end
            object grpLauncher2Tetral: TGroupBox
              Left = 41
              Top = 202
              Width = 178
              Height = 171
              Caption = 'AFT Launcher'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              object imgLoadAFTTet1: TImage
                Left = 33
                Top = 33
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgLoadAFTTet2: TImage
                Left = 33
                Top = 80
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgLoadAFTTet3: TImage
                Left = 110
                Top = 32
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgLoadAFTTet4: TImage
                Left = 110
                Top = 79
                Width = 17
                Height = 17
                Transparent = True
              end
              object lbl97: TLabel
                Left = 15
                Top = 35
                Width = 8
                Height = 13
                Caption = '1'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lbl98: TLabel
                Left = 14
                Top = 82
                Width = 8
                Height = 13
                Caption = '2'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lbl99: TLabel
                Left = 91
                Top = 35
                Width = 8
                Height = 13
                Caption = '3'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lbl100: TLabel
                Left = 91
                Top = 83
                Width = 8
                Height = 13
                Caption = '4'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object btn2TetralLoading4: TButton
                Tag = 1
                Left = 81
                Top = 132
                Width = 79
                Height = 23
                Caption = 'Load'
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
                OnClick = btnTetralLoadingClick
              end
              object cbbLoadTetralAFT: TComboBox
                Left = 20
                Top = 133
                Width = 46
                Height = 21
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 1
                Text = '1'
                Items.Strings = (
                  '1'
                  '2'
                  '3'
                  '4'
                  'All')
              end
            end
          end
        end
      end
      object rzgrpTocos: TRzGroup
        CaptionFont.Charset = DEFAULT_CHARSET
        CaptionFont.Color = clWindowText
        CaptionFont.Height = -11
        CaptionFont.Name = 'MS Sans Serif'
        CaptionFont.Style = [fsBold]
        Color = clGray
        ColorDefault = False
        Items = <>
        Opened = False
        OpenedHeight = 842
        DividerVisible = False
        Caption = 'TOCOS'
        ParentColor = False
        Visible = False
        object ScrlbxTOCOS: TScrollBox
          Left = 0
          Top = 20
          Width = 397
          Height = 0
          Align = alClient
          Color = clGray
          ParentColor = False
          TabOrder = 0
          object Bevel1: TBevel
            Left = 45
            Top = 41
            Width = 268
            Height = 1
          end
          object lbl92: TLabel
            Left = 159
            Top = 12
            Width = 54
            Height = 19
            Caption = 'TOCOS'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -16
            Font.Name = 'Times New Roman'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object grp13: TGroupBox
            Left = 39
            Top = 242
            Width = 278
            Height = 550
            Caption = 'Status Console'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object lbl26: TLabel
              Left = 22
              Top = 366
              Width = 28
              Height = 13
              Caption = 'Fuse'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Visible = False
            end
            object lbl25: TLabel
              Left = 22
              Top = 344
              Width = 32
              Height = 13
              Caption = 'Temp'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              Visible = False
            end
            object Label8: TLabel
              Left = 22
              Top = 389
              Width = 73
              Height = 13
              BiDiMode = bdLeftToRight
              Caption = 'Power Reset'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentBiDiMode = False
              ParentFont = False
              Visible = False
            end
            object Label7: TLabel
              Left = 22
              Top = 130
              Width = 39
              Height = 13
              BiDiMode = bdLeftToRight
              Caption = 'Supply'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentBiDiMode = False
              ParentFont = False
            end
            object Label27: TLabel
              Left = 217
              Top = 278
              Width = 25
              Height = 13
              BiDiMode = bdLeftToRight
              Caption = 'TCC'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentBiDiMode = False
              ParentFont = False
              Visible = False
            end
            object Label26: TLabel
              Left = 177
              Top = 278
              Width = 29
              Height = 13
              BiDiMode = bdLeftToRight
              Caption = 'WEC'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentBiDiMode = False
              ParentFont = False
              Visible = False
            end
            object Label25: TLabel
              Left = 22
              Top = 322
              Width = 84
              Height = 13
              BiDiMode = bdLeftToRight
              Caption = 'CASSTABAVL '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentBiDiMode = False
              ParentFont = False
              Visible = False
            end
            object Label24: TLabel
              Left = 22
              Top = 305
              Width = 80
              Height = 13
              BiDiMode = bdLeftToRight
              Caption = 'EXTSTABAVL'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentBiDiMode = False
              ParentFont = False
              Visible = False
            end
            object Label23: TLabel
              Left = 22
              Top = 226
              Width = 81
              Height = 13
              BiDiMode = bdLeftToRight
              Caption = 'Ready To Fire'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentBiDiMode = False
              ParentFont = False
            end
            object Label22: TLabel
              Left = 22
              Top = 207
              Width = 82
              Height = 13
              BiDiMode = bdLeftToRight
              Caption = 'Torpedo Open'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentBiDiMode = False
              ParentFont = False
            end
            object Label21: TLabel
              Left = 22
              Top = 188
              Width = 62
              Height = 13
              BiDiMode = bdLeftToRight
              Caption = 'Door Open'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentBiDiMode = False
              ParentFont = False
            end
            object Label20: TLabel
              Left = 22
              Top = 170
              Width = 44
              Height = 13
              BiDiMode = bdLeftToRight
              Caption = '20 BAR'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentBiDiMode = False
              ParentFont = False
            end
            object Label19: TLabel
              Left = 22
              Top = 150
              Width = 51
              Height = 13
              BiDiMode = bdLeftToRight
              Caption = '120 BAR'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentBiDiMode = False
              ParentFont = False
            end
            object Label18: TLabel
              Left = 22
              Top = 110
              Width = 78
              Height = 13
              BiDiMode = bdLeftToRight
              Caption = 'Indikator Port'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentBiDiMode = False
              ParentFont = False
            end
            object Label17: TLabel
              Left = 217
              Top = 88
              Width = 20
              Height = 13
              BiDiMode = bdLeftToRight
              Caption = 'Stb'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentBiDiMode = False
              ParentFont = False
            end
            object Label16: TLabel
              Left = 177
              Top = 88
              Width = 24
              Height = 13
              BiDiMode = bdLeftToRight
              Caption = 'Port'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentBiDiMode = False
              ParentFont = False
            end
            object Label15: TLabel
              Left = 22
              Top = 498
              Width = 79
              Height = 13
              BiDiMode = bdLeftToRight
              Caption = 'Load Program'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentBiDiMode = False
              ParentFont = False
              Visible = False
            end
            object Label14: TLabel
              Left = 22
              Top = 479
              Width = 124
              Height = 13
              BiDiMode = bdLeftToRight
              Caption = 'Anti Condens Heating'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentBiDiMode = False
              ParentFont = False
              Visible = False
            end
            object Label13: TLabel
              Left = 22
              Top = 53
              Width = 42
              Height = 13
              BiDiMode = bdLeftToRight
              Caption = 'NUG_2'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentBiDiMode = False
              ParentFont = False
            end
            object Label12: TLabel
              Left = 22
              Top = 34
              Width = 42
              Height = 13
              BiDiMode = bdLeftToRight
              Caption = 'NUG_1'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentBiDiMode = False
              ParentFont = False
            end
            object Label11: TLabel
              Left = 22
              Top = 436
              Width = 45
              Height = 13
              BiDiMode = bdLeftToRight
              Caption = 'SOFTW'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentBiDiMode = False
              ParentFont = False
              Visible = False
            end
            object Label10: TLabel
              Left = 22
              Top = 416
              Width = 44
              Height = 13
              BiDiMode = bdLeftToRight
              Caption = 'CMPTR'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentBiDiMode = False
              ParentFont = False
              Visible = False
            end
            object bvl6: TBevel
              Left = 21
              Top = 136
              Width = 268
              Height = 0
            end
            object bvl13: TBevel
              Left = 22
              Top = 263
              Width = 242
              Height = 6
            end
            object bvl12: TBevel
              Left = 22
              Top = 75
              Width = 235
              Height = 6
            end
            object cbbTOCOSTempWEC: TCheckBox
              Left = 184
              Top = 344
              Width = 17
              Height = 17
              TabOrder = 0
              Visible = False
            end
            object cbbTOCOSTempTEC: TCheckBox
              Left = 224
              Top = 344
              Width = 35
              Height = 17
              TabOrder = 1
              Visible = False
            end
            object cbbTOCOSStbTorpOpen: TCheckBox
              Left = 219
              Top = 206
              Width = 33
              Height = 17
              TabOrder = 2
            end
            object cbbTOCOSStbSupply: TCheckBox
              Left = 219
              Top = 128
              Width = 33
              Height = 17
              TabOrder = 3
            end
            object cbbTOCOSStbRtoFire: TCheckBox
              Left = 219
              Top = 225
              Width = 49
              Height = 17
              TabOrder = 4
            end
            object cbbTOCOSStbInP: TCheckBox
              Left = 219
              Top = 108
              Width = 43
              Height = 17
              TabOrder = 5
            end
            object cbbTOCOSStbDoorOpen: TCheckBox
              Left = 219
              Top = 186
              Width = 41
              Height = 17
              TabOrder = 6
            end
            object cbbTOCOSStb20: TCheckBox
              Left = 219
              Top = 167
              Width = 25
              Height = 17
              TabOrder = 7
            end
            object cbbTOCOSStb120: TCheckBox
              Left = 219
              Top = 148
              Width = 33
              Height = 17
              TabOrder = 8
            end
            object cbbTOCOSSOFTTW: TCheckBox
              Left = 184
              Top = 433
              Width = 35
              Height = 17
              TabOrder = 9
              Visible = False
            end
            object cbbTOCOSPwrRstWEC: TCheckBox
              Left = 184
              Top = 384
              Width = 27
              Height = 17
              TabOrder = 10
              Visible = False
            end
            object cbbTOCOSPwrRstTCC: TCheckBox
              Left = 224
              Top = 384
              Width = 27
              Height = 17
              TabOrder = 11
              Visible = False
            end
            object cbbTOCOSPortTorpOpen: TCheckBox
              Left = 182
              Top = 206
              Width = 33
              Height = 17
              TabOrder = 12
            end
            object cbbTOCOSPortSupply: TCheckBox
              Left = 182
              Top = 128
              Width = 27
              Height = 17
              TabOrder = 13
            end
            object cbbTOCOSPortRtoFire: TCheckBox
              Left = 182
              Top = 225
              Width = 33
              Height = 17
              TabOrder = 14
            end
            object cbbTOCOSPortInP: TCheckBox
              Left = 182
              Top = 108
              Width = 19
              Height = 17
              TabOrder = 15
            end
            object cbbTOCOSPortDoorOpen: TCheckBox
              Left = 182
              Top = 186
              Width = 33
              Height = 17
              TabOrder = 16
            end
            object cbbTOCOSPort20: TCheckBox
              Left = 182
              Top = 167
              Width = 33
              Height = 17
              TabOrder = 17
            end
            object cbbTOCOSPort120: TCheckBox
              Left = 182
              Top = 148
              Width = 27
              Height = 17
              TabOrder = 18
            end
            object cbbTOCOSNUG2: TCheckBox
              Left = 182
              Top = 50
              Width = 19
              Height = 17
              TabOrder = 19
            end
            object cbbTOCOSNUG1: TCheckBox
              Left = 182
              Top = 34
              Width = 27
              Height = 17
              TabOrder = 20
            end
            object cbbTOCOSLoadProgram: TCheckBox
              Left = 184
              Top = 496
              Width = 35
              Height = 17
              TabOrder = 21
              Visible = False
            end
            object cbbTOCOSFuseWEC: TCheckBox
              Left = 184
              Top = 364
              Width = 27
              Height = 17
              TabOrder = 22
              Visible = False
            end
            object cbbTOCOSFuseTCC: TCheckBox
              Left = 224
              Top = 364
              Width = 27
              Height = 17
              TabOrder = 23
              Visible = False
            end
            object cbbTOCOSExtStabAvl: TCheckBox
              Left = 182
              Top = 301
              Width = 19
              Height = 17
              TabOrder = 24
              Visible = False
            end
            object cbbTOCOSCMPTR: TCheckBox
              Left = 184
              Top = 413
              Width = 35
              Height = 17
              TabOrder = 25
              Visible = False
            end
            object cbbTOCOSCasAblAvl: TCheckBox
              Left = 182
              Top = 320
              Width = 25
              Height = 17
              TabOrder = 26
              Visible = False
            end
            object cbbTOCOSAntiCondensHeating: TCheckBox
              Left = 184
              Top = 477
              Width = 26
              Height = 17
              TabOrder = 27
              Visible = False
            end
          end
          object grp14: TGroupBox
            Left = 38
            Top = 48
            Width = 277
            Height = 175
            Caption = 'Status Launcher'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            object grpLauncher1Tocos: TGroupBox
              Left = 15
              Top = 27
              Width = 245
              Height = 59
              Caption = 'Port'
              Color = clGray
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              TabOrder = 0
              object imgLoadTocos1: TImage
                Left = 24
                Top = 24
                Width = 17
                Height = 17
                Transparent = True
              end
              object btnTocosLoading: TButton
                Left = 121
                Top = 22
                Width = 108
                Height = 25
                Caption = 'Load'
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
                OnClick = btnTocosLoadingClick
              end
            end
            object grpLauncher2Tocos: TGroupBox
              Left = 14
              Top = 92
              Width = 247
              Height = 59
              Caption = 'StarBoard'
              Color = clGray
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              TabOrder = 1
              object imgLoadTocos2: TImage
                Left = 24
                Top = 24
                Width = 17
                Height = 17
                Transparent = True
              end
              object btnTocosLoading2: TButton
                Tag = 1
                Left = 123
                Top = 22
                Width = 108
                Height = 25
                Caption = 'Load'
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
                OnClick = btnTocosLoadingClick
              end
            end
          end
        end
      end
      object rzgrpYakhont: TRzGroup
        CaptionFont.Charset = DEFAULT_CHARSET
        CaptionFont.Color = clWindowText
        CaptionFont.Height = -11
        CaptionFont.Name = 'MS Sans Serif'
        CaptionFont.Style = [fsBold]
        Color = clGray
        ColorDefault = False
        Items = <>
        Opened = True
        OpenedHeight = 842
        DividerVisible = False
        Caption = 'YAKHONT'
        ParentColor = False
        Visible = False
        object scrlbxYakhont: TScrollBox
          Left = 0
          Top = 20
          Width = 397
          Height = 943
          Align = alClient
          Color = clGray
          ParentColor = False
          TabOrder = 0
          ExplicitHeight = 0
          object lblYakhontStatus: TLabel
            Left = 151
            Top = 11
            Width = 78
            Height = 19
            Caption = 'YAKHONT'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -16
            Font.Name = 'Times New Roman'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object bvl4: TBevel
            Left = 45
            Top = 41
            Width = 268
            Height = 1
          end
          object grpAssignYahkont: TGroupBox
            Left = 41
            Top = 564
            Width = 268
            Height = 105
            Caption = 'AssignYahkont'
            TabOrder = 0
            object btnYAKHONTTrack: TSpeedButton
              Tag = 2
              Left = 198
              Top = 26
              Width = 27
              Height = 22
              Glyph.Data = {
                36090000424D360900000000000036000000280000001F000000180000000100
                18000000000000090000000000000000000000000000000000006161613E3E3E
                3737374040403B3B3B3A3A3A4141414141413A3A3A3A3A3A4040403737373E3E
                3E3D3D3D3838384141413A3A3A3B3B3B4040403737373E3E3E3D3D3D38383841
                41413A3A3A3B3B3B4040403737373E3E3E3C3C3C383838000000B2B2B27C7C7C
                7474747F7F7F7878787777778080808080807878787878788080807474747C7C
                7C7B7B7B7474748080807A7A7A7A7A7A7F7F7F7474747C7C7C7B7B7B74747480
                80807777777979797F7F7F7474747D7D7D7A7A7A757575000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2BDBDBDBBBBBBB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2C0C0C04949
                491111111111111111111212121212121A1A1AB2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B29191914D4D4D5454545F5F
                5F6565656262620000004747476565656363634D4D4D4D4D4D797979BABABAB2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B29797976969692929292929298686
                86B2B2B2ADADAD0000007D7D7DB2B2B2ABABAB292929292929545454979797B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B23D3D3D3B3B3BB2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B26A6A6A0E0E0EB2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B21616166F6F6FA5A5A5B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2AAAAAA94949413
                13138A8A8AB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2030303757575B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2A4A4A400
                0000868686B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2A6A6A68B8B8B2C2C2C838383B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007F7F7FB4B4B4B2B2B2B2B2B2B2B2B2B2B2B2A7A7A727
                27277272729C9C9CB2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000BDBDBDB7B7B7B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD000000888888BBBBBBB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B22C2C2C4C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000B0B0B0B3B3B3B2B2B2B2B2B2BFBFBFB6B6
                B6B2B2B2B1B1B19D9D9DADADADB3B3B3B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3BF
                BFBF3030304C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B0000004F4F4F5151515151515151515858585353
                53737373B2B2B2B2B2B2B2B2B28D8D8D51515151515151515151515152525258
                58581616164C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B0000002424242525252525252525252525252525
                25575757B2B2B2B2B2B2B2B2B27D7D7D25252525252525252525252525252525
                25250909094C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000AFAFAFB2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B22C2C2C4C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000BBBBBBB6B6B6B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD171717848484B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B22C2C2C4C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B29999995F5F5F5A5A5A949494B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B5B5B5B2B2B253
                53535C5C5C828282B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2030303757575B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B7B7B7AFAFAF00
                0000868686B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2030303757575B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2A4A4A400
                0000868686B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B29A9A9A4545454B4B4BB2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B274747423232399
                9999ACACACB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B27A7A7A5A5A5A5555555555559494
                94B5B5B5B4B4B4000000838383B7B7B7ADADAD555555555555585858646464B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B28282822121212121216D6D
                6D9595959898980000006E6E6E9898988B8B8B2121212121215B5B5BB2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B23939
                39000000000000000000000000000000090909B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2A0A0
                A0979797979797979797979797979797999999B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000}
            end
            object edtYAKHONTTtrack: TEdit
              Left = 11
              Top = 26
              Width = 180
              Height = 21
              TabOrder = 0
            end
            object btnYAKHONTAssign: TButton
              Tag = 1
              Left = 11
              Top = 61
              Width = 70
              Height = 24
              Caption = 'Assign'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              OnClick = btnYAKHONTAssignClick
            end
            object btnYAKHONTDeAssign: TButton
              Tag = 2
              Left = 87
              Top = 60
              Width = 66
              Height = 25
              Caption = 'Cancel'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
              OnClick = btnYAKHONTAssignClick
            end
          end
          object grpLauncher1Yakhont: TGroupBox
            Left = 44
            Top = 71
            Width = 268
            Height = 129
            Caption = 'Status Launcher'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            object imgLoadYakhont1: TImage
              Left = 40
              Top = 34
              Width = 17
              Height = 17
              Transparent = True
            end
            object imgLoadYakhont2: TImage
              Left = 39
              Top = 79
              Width = 17
              Height = 17
              Transparent = True
            end
            object imgLoadYakhont3: TImage
              Left = 109
              Top = 34
              Width = 17
              Height = 17
              Transparent = True
            end
            object imgLoadYakhont4: TImage
              Left = 109
              Top = 78
              Width = 17
              Height = 17
              Transparent = True
            end
            object lbl84: TLabel
              Left = 21
              Top = 35
              Width = 8
              Height = 13
              Caption = '1'
            end
            object lbl85: TLabel
              Left = 93
              Top = 35
              Width = 8
              Height = 13
              Caption = '3'
            end
            object lbl86: TLabel
              Left = 21
              Top = 82
              Width = 8
              Height = 13
              Caption = '2'
            end
            object lbl87: TLabel
              Left = 94
              Top = 80
              Width = 8
              Height = 13
              Caption = '4'
            end
            object btnYakhontLoading4: TButton
              Tag = 3
              Left = 168
              Top = 75
              Width = 71
              Height = 22
              Caption = 'Load'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              OnClick = btnYAKHONTAssignClick
            end
            object cbbLoadYakhont: TComboBox
              Left = 167
              Top = 36
              Width = 68
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              Text = '1'
              Items.Strings = (
                '1'
                '2'
                '3'
                '4'
                'All')
            end
          end
          object grpLauncher4Yakhont: TGroupBox
            Left = 43
            Top = 216
            Width = 268
            Height = 305
            Caption = 'Status Console'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            object chkYakhont_Printer: TCheckBox
              Tag = 601
              Left = 19
              Top = 32
              Width = 137
              Height = 17
              Caption = 'Printer'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
            end
            object chkYakhontConsoleN1: TCheckBox
              Tag = 602
              Left = 19
              Top = 56
              Width = 137
              Height = 17
              Caption = 'Console N1'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
            end
            object chkYakhontConsoleN2: TCheckBox
              Tag = 603
              Left = 19
              Top = 80
              Width = 137
              Height = 17
              Caption = 'Console N2'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
            end
            object chkYakhontLauncherR1: TCheckBox
              Tag = 604
              Left = 19
              Top = 104
              Width = 137
              Height = 17
              Caption = 'Launcher Right 1'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 3
            end
            object chkYakhontLauncherR3: TCheckBox
              Tag = 605
              Left = 19
              Top = 128
              Width = 137
              Height = 17
              Caption = 'Launcher Right 3'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 4
            end
            object chkYakhontLauncherL2: TCheckBox
              Tag = 606
              Left = 19
              Top = 152
              Width = 137
              Height = 17
              Caption = 'Launcher Left 2'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 5
            end
            object chkYakhontLauncherL4: TCheckBox
              Tag = 607
              Left = 19
              Top = 176
              Width = 137
              Height = 17
              Caption = 'Launcher Left 4'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 6
            end
            object chkYakhontKR231: TCheckBox
              Tag = 608
              Left = 19
              Top = 200
              Width = 137
              Height = 17
              Caption = 'KR231'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 7
            end
            object chkYakhontGyro: TCheckBox
              Tag = 609
              Left = 19
              Top = 224
              Width = 137
              Height = 17
              Caption = 'GYRO'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 8
            end
            object chkYakhontINS300V: TCheckBox
              Tag = 610
              Left = 19
              Top = 248
              Width = 137
              Height = 17
              Caption = 'INS300V'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 9
            end
            object chkYakhontINS27V: TCheckBox
              Tag = 611
              Left = 19
              Top = 272
              Width = 137
              Height = 17
              Caption = 'INS27V'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 10
            end
          end
          object btn2: TButton
            Left = 42
            Top = 530
            Width = 97
            Height = 25
            Caption = 'buat test report'
            TabOrder = 3
            Visible = False
            OnClick = btn2Click
          end
        end
      end
      object rzgrpCannon40: TRzGroup
        CaptionFont.Charset = DEFAULT_CHARSET
        CaptionFont.Color = clWindowText
        CaptionFont.Height = -11
        CaptionFont.Name = 'MS Sans Serif'
        CaptionFont.Style = [fsBold]
        Color = clGray
        ColorDefault = False
        Items = <>
        Opened = False
        OpenedHeight = 842
        DividerVisible = False
        Caption = 'CANNON 40'
        ParentColor = False
        Visible = False
        object scrlbxCannon40: TScrollBox
          Left = 0
          Top = 20
          Width = 397
          Height = 0
          Align = alClient
          Color = clGray
          ParentColor = False
          TabOrder = 0
          object lbl2: TLabel
            Left = 143
            Top = 10
            Width = 90
            Height = 19
            Caption = 'CANNON 40'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -16
            Font.Name = 'Times New Roman'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object bvl8: TBevel
            Left = 45
            Top = 41
            Width = 268
            Height = 1
          end
          object chkCannon40EnableCannon: TCheckBox
            Tag = 601
            Left = 45
            Top = 65
            Width = 137
            Height = 17
            Caption = 'Enable Cannon'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
        end
      end
      object rzgrpC802: TRzGroup
        CaptionFont.Charset = DEFAULT_CHARSET
        CaptionFont.Color = clWindowText
        CaptionFont.Height = -11
        CaptionFont.Name = 'MS Sans Serif'
        CaptionFont.Style = [fsBold]
        Color = clGray
        ColorDefault = False
        Items = <>
        Opened = False
        OpenedHeight = 842
        DividerVisible = False
        Caption = 'C802'
        ParentColor = False
        Visible = False
        object scrlbxC802: TScrollBox
          Left = 0
          Top = 20
          Width = 397
          Height = 0
          Align = alClient
          Color = clGray
          ParentColor = False
          TabOrder = 0
          object Bevel2: TBevel
            Left = 45
            Top = 41
            Width = 292
            Height = 1
          end
          object Label9: TLabel
            Left = 176
            Top = 11
            Width = 35
            Height = 19
            Caption = 'C802'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -16
            Font.Name = 'Times New Roman'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object grpAssignC802: TGroupBox
            Left = 38
            Top = 642
            Width = 297
            Height = 105
            Caption = 'AssignC802'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            Visible = False
            object btnC802Track: TSpeedButton
              Tag = 4
              Left = 198
              Top = 26
              Width = 27
              Height = 22
              Glyph.Data = {
                36090000424D360900000000000036000000280000001F000000180000000100
                18000000000000090000000000000000000000000000000000006161613E3E3E
                3737374040403B3B3B3A3A3A4141414141413A3A3A3A3A3A4040403737373E3E
                3E3D3D3D3838384141413A3A3A3B3B3B4040403737373E3E3E3D3D3D38383841
                41413A3A3A3B3B3B4040403737373E3E3E3C3C3C383838000000B2B2B27C7C7C
                7474747F7F7F7878787777778080808080807878787878788080807474747C7C
                7C7B7B7B7474748080807A7A7A7A7A7A7F7F7F7474747C7C7C7B7B7B74747480
                80807777777979797F7F7F7474747D7D7D7A7A7A757575000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2BDBDBDBBBBBBB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2C0C0C04949
                491111111111111111111212121212121A1A1AB2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B29191914D4D4D5454545F5F
                5F6565656262620000004747476565656363634D4D4D4D4D4D797979BABABAB2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B29797976969692929292929298686
                86B2B2B2ADADAD0000007D7D7DB2B2B2ABABAB292929292929545454979797B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B23D3D3D3B3B3BB2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B26A6A6A0E0E0EB2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B21616166F6F6FA5A5A5B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2AAAAAA94949413
                13138A8A8AB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2030303757575B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2A4A4A400
                0000868686B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2A6A6A68B8B8B2C2C2C838383B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007F7F7FB4B4B4B2B2B2B2B2B2B2B2B2B2B2B2A7A7A727
                27277272729C9C9CB2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000BDBDBDB7B7B7B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD000000888888BBBBBBB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B22C2C2C4C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000B0B0B0B3B3B3B2B2B2B2B2B2BFBFBFB6B6
                B6B2B2B2B1B1B19D9D9DADADADB3B3B3B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3BF
                BFBF3030304C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B0000004F4F4F5151515151515151515858585353
                53737373B2B2B2B2B2B2B2B2B28D8D8D51515151515151515151515152525258
                58581616164C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B0000002424242525252525252525252525252525
                25575757B2B2B2B2B2B2B2B2B27D7D7D25252525252525252525252525252525
                25250909094C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000AFAFAFB2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B22C2C2C4C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000BBBBBBB6B6B6B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD171717848484B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B22C2C2C4C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B29999995F5F5F5A5A5A949494B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B5B5B5B2B2B253
                53535C5C5C828282B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2030303757575B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B7B7B7AFAFAF00
                0000868686B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2030303757575B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2A4A4A400
                0000868686B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B29A9A9A4545454B4B4BB2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B274747423232399
                9999ACACACB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B27A7A7A5A5A5A5555555555559494
                94B5B5B5B4B4B4000000838383B7B7B7ADADAD555555555555585858646464B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B28282822121212121216D6D
                6D9595959898980000006E6E6E9898988B8B8B2121212121215B5B5BB2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B23939
                39000000000000000000000000000000090909B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2A0A0
                A0979797979797979797979797979797999999B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000}
            end
            object edtC802Track: TEdit
              Left = 7
              Top = 26
              Width = 180
              Height = 21
              TabOrder = 0
            end
            object btnC802Assign: TButton
              Tag = 1
              Left = 8
              Top = 61
              Width = 91
              Height = 25
              Caption = 'Assign'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              OnClick = btnC802AssignClick
            end
            object btnC802DeAssign: TButton
              Tag = 2
              Left = 103
              Top = 61
              Width = 85
              Height = 25
              Caption = 'Cancel'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
              OnClick = btnC802AssignClick
            end
          end
          object grp8: TGroupBox
            Left = 40
            Top = 48
            Width = 297
            Height = 137
            Caption = 'Status Launcher'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            object imgLoadC802_1: TImage
              Left = 116
              Top = 27
              Width = 17
              Height = 17
              Transparent = True
            end
            object imgLoadC802_2: TImage
              Left = 39
              Top = 28
              Width = 17
              Height = 17
              Transparent = True
            end
            object imgC802_3: TImage
              Left = 117
              Top = 83
              Width = 17
              Height = 17
              Transparent = True
            end
            object imgC802_4: TImage
              Left = 40
              Top = 84
              Width = 17
              Height = 17
              Transparent = True
            end
            object lbl80: TLabel
              Left = 104
              Top = 30
              Width = 8
              Height = 13
              Caption = '1'
            end
            object lbl81: TLabel
              Left = 24
              Top = 31
              Width = 8
              Height = 13
              Caption = '2'
            end
            object lbl82: TLabel
              Left = 104
              Top = 86
              Width = 8
              Height = 13
              Caption = '3'
            end
            object lbl83: TLabel
              Left = 24
              Top = 86
              Width = 8
              Height = 13
              Caption = '4'
            end
            object btn9: TButton
              Tag = 3
              Left = 179
              Top = 77
              Width = 75
              Height = 23
              Caption = 'Load'
              TabOrder = 0
              OnClick = btnC802AssignClick
            end
            object cbbLoadC802: TComboBox
              Left = 179
              Top = 30
              Width = 72
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              Text = '1'
              Items.Strings = (
                '1'
                '2'
                '3'
                '4'
                'All')
            end
          end
          object grp9: TGroupBox
            Left = 38
            Top = 195
            Width = 298
            Height = 433
            Caption = 'Status Console'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            object grpC802Launcher1: TGroupBox
              Left = 14
              Top = 24
              Width = 268
              Height = 81
              Caption = 'Launcher 1'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              object chkC802PrelaunchCheck1: TCheckBox
                Tag = 701
                Left = 16
                Top = 16
                Width = 153
                Height = 17
                Caption = 'Prelaunch Check'
                TabOrder = 0
              end
              object chkC802LaunchReadyCondition1: TCheckBox
                Tag = 710
                Left = 16
                Top = 32
                Width = 129
                Height = 17
                Caption = 'Launch Ready'
                TabOrder = 1
              end
              object chkC802Launch1: TCheckBox
                Tag = 717
                Left = 16
                Top = 48
                Width = 97
                Height = 17
                Caption = 'Launch'
                TabOrder = 2
              end
            end
            object grpC802Launcher2: TGroupBox
              Left = 13
              Top = 125
              Width = 269
              Height = 82
              Caption = 'Launcher 2'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              object chkC802PrelaunchCheck2: TCheckBox
                Tag = 701
                Left = 16
                Top = 16
                Width = 153
                Height = 17
                Caption = 'Prelaunch Check'
                TabOrder = 0
              end
              object chkC802LaunchReadyCondition2: TCheckBox
                Tag = 710
                Left = 16
                Top = 32
                Width = 129
                Height = 17
                Caption = 'Launch Ready'
                TabOrder = 1
              end
              object chkC802Launch2: TCheckBox
                Tag = 717
                Left = 16
                Top = 48
                Width = 97
                Height = 17
                Caption = 'Launch'
                TabOrder = 2
              end
            end
            object grpC802Launcher3: TGroupBox
              Left = 13
              Top = 228
              Width = 268
              Height = 83
              Caption = 'Launcher 3'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
              object chkC802PrelaunchCheck3: TCheckBox
                Tag = 701
                Left = 16
                Top = 16
                Width = 153
                Height = 17
                Caption = 'Prelaunch Check'
                TabOrder = 0
              end
              object chkC802LaunchReadyCondition3: TCheckBox
                Tag = 710
                Left = 16
                Top = 32
                Width = 129
                Height = 17
                Caption = 'Launch Ready'
                TabOrder = 1
              end
              object chkC802Launch3: TCheckBox
                Tag = 717
                Left = 16
                Top = 48
                Width = 97
                Height = 17
                Caption = 'Launch'
                TabOrder = 2
              end
            end
            object grpC802Launcher4: TGroupBox
              Left = 13
              Top = 333
              Width = 268
              Height = 82
              Caption = 'Launcher 4'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 3
              object chkC802PrelaunchCheck4: TCheckBox
                Tag = 701
                Left = 16
                Top = 16
                Width = 153
                Height = 17
                Caption = 'Prelaunch Check'
                TabOrder = 0
              end
              object chkC802LaunchReadyCondition4: TCheckBox
                Tag = 710
                Left = 16
                Top = 32
                Width = 129
                Height = 17
                Caption = 'Launch Ready'
                TabOrder = 1
              end
              object chkC802Launch4: TCheckBox
                Tag = 717
                Left = 16
                Top = 48
                Width = 97
                Height = 17
                Caption = 'Launch'
                TabOrder = 2
              end
            end
          end
        end
      end
      object rzgrpWCC: TRzGroup
        CaptionFont.Charset = DEFAULT_CHARSET
        CaptionFont.Color = clWindowText
        CaptionFont.Height = -11
        CaptionFont.Name = 'MS Sans Serif'
        CaptionFont.Style = [fsBold]
        Color = clGray
        ColorDefault = False
        Items = <>
        Opened = False
        OpenedHeight = 842
        DividerVisible = False
        Caption = 'WCC'
        ParentColor = False
        Visible = False
        object scrlbxWCC: TScrollBox
          Left = 0
          Top = 20
          Width = 397
          Height = 0
          Align = alClient
          Color = clGray
          ParentColor = False
          TabOrder = 0
          object pnlWCCIner: TPanel
            Left = 0
            Top = 0
            Width = 397
            Height = 0
            Align = alClient
            BevelOuter = bvNone
            BorderStyle = bsSingle
            Color = clGray
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -20
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object bvl3: TBevel
              Left = 45
              Top = 41
              Width = 268
              Height = 1
            end
            object lbl27: TLabel
              Left = 159
              Top = 11
              Width = 37
              Height = 19
              Caption = 'WCC'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWhite
              Font.Height = -16
              Font.Name = 'Times New Roman'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object chk36: TCheckBox
              Tag = 501
              Left = 44
              Top = 65
              Width = 97
              Height = 17
              Caption = 'RRNF'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
            end
            object chk58: TCheckBox
              Tag = 502
              Left = 44
              Top = 89
              Width = 97
              Height = 17
              Caption = 'RPC LPC'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
            end
            object chk80: TCheckBox
              Tag = 503
              Left = 44
              Top = 113
              Width = 129
              Height = 17
              Caption = 'RDY RH LH MAG'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
            end
            object chk81: TCheckBox
              Tag = 504
              Left = 44
              Top = 138
              Width = 113
              Height = 17
              Caption = 'RADAR ERROR'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 3
            end
            object chk82: TCheckBox
              Tag = 505
              Left = 44
              Top = 162
              Width = 97
              Height = 17
              Caption = 'COMPUTER'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 4
            end
            object chk83: TCheckBox
              Tag = 506
              Left = 44
              Top = 186
              Width = 97
              Height = 17
              Caption = 'SYN GUN 2'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 5
            end
            object chk84: TCheckBox
              Tag = 507
              Left = 45
              Top = 211
              Width = 97
              Height = 17
              Caption = 'SYN GUN 3'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 6
            end
          end
        end
      end
      object rzgrpAsroc: TRzGroup
        CaptionFont.Charset = DEFAULT_CHARSET
        CaptionFont.Color = clWindowText
        CaptionFont.Height = -11
        CaptionFont.Name = 'MS Sans Serif'
        CaptionFont.Style = [fsBold]
        Color = clGray
        ColorDefault = False
        Items = <>
        Opened = False
        OpenedHeight = 830
        DividerVisible = False
        Caption = 'ASROC'
        ParentColor = False
        Visible = False
        object scrlbxASROC: TScrollBox
          Left = 0
          Top = 20
          Width = 397
          Height = 0
          Align = alClient
          Color = clGray
          ParentColor = False
          TabOrder = 0
          object lbl16: TLabel
            Left = 144
            Top = 11
            Width = 93
            Height = 19
            Caption = 'ASROC-TDC'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -16
            Font.Name = 'Times New Roman'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object bvlASROC: TBevel
            Left = 45
            Top = 41
            Width = 268
            Height = 1
          end
          object pnlAssignAsroc: TPanel
            Left = 44
            Top = 468
            Width = 266
            Height = 105
            BorderStyle = bsSingle
            Color = clGray
            TabOrder = 0
            object lblAssignAsroc: TLabel
              Left = 13
              Top = 3
              Width = 142
              Height = 13
              Caption = 'ASSIGN FIRE CONTROL'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object btnASROCTrack: TSpeedButton
              Tag = 1
              Left = 198
              Top = 26
              Width = 27
              Height = 22
              Glyph.Data = {
                36090000424D360900000000000036000000280000001F000000180000000100
                18000000000000090000000000000000000000000000000000006161613E3E3E
                3737374040403B3B3B3A3A3A4141414141413A3A3A3A3A3A4040403737373E3E
                3E3D3D3D3838384141413A3A3A3B3B3B4040403737373E3E3E3D3D3D38383841
                41413A3A3A3B3B3B4040403737373E3E3E3C3C3C383838000000B2B2B27C7C7C
                7474747F7F7F7878787777778080808080807878787878788080807474747C7C
                7C7B7B7B7474748080807A7A7A7A7A7A7F7F7F7474747C7C7C7B7B7B74747480
                80807777777979797F7F7F7474747D7D7D7A7A7A757575000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2BDBDBDBBBBBBB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2C0C0C04949
                491111111111111111111212121212121A1A1AB2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B29191914D4D4D5454545F5F
                5F6565656262620000004747476565656363634D4D4D4D4D4D797979BABABAB2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B29797976969692929292929298686
                86B2B2B2ADADAD0000007D7D7DB2B2B2ABABAB292929292929545454979797B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B23D3D3D3B3B3BB2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B26A6A6A0E0E0EB2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B21616166F6F6FA5A5A5B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2AAAAAA94949413
                13138A8A8AB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2030303757575B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2A4A4A400
                0000868686B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2A6A6A68B8B8B2C2C2C838383B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007F7F7FB4B4B4B2B2B2B2B2B2B2B2B2B2B2B2A7A7A727
                27277272729C9C9CB2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000BDBDBDB7B7B7B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD000000888888BBBBBBB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B22C2C2C4C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000B0B0B0B3B3B3B2B2B2B2B2B2BFBFBFB6B6
                B6B2B2B2B1B1B19D9D9DADADADB3B3B3B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3BF
                BFBF3030304C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B0000004F4F4F5151515151515151515858585353
                53737373B2B2B2B2B2B2B2B2B28D8D8D51515151515151515151515152525258
                58581616164C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B0000002424242525252525252525252525252525
                25575757B2B2B2B2B2B2B2B2B27D7D7D25252525252525252525252525252525
                25250909094C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000AFAFAFB2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B22C2C2C4C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000BBBBBBB6B6B6B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD171717848484B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B22C2C2C4C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B29999995F5F5F5A5A5A949494B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B5B5B5B2B2B253
                53535C5C5C828282B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2030303757575B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B7B7B7AFAFAF00
                0000868686B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2030303757575B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2A4A4A400
                0000868686B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B29A9A9A4545454B4B4BB2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B274747423232399
                9999ACACACB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B27A7A7A5A5A5A5555555555559494
                94B5B5B5B4B4B4000000838383B7B7B7ADADAD555555555555585858646464B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B28282822121212121216D6D
                6D9595959898980000006E6E6E9898988B8B8B2121212121215B5B5BB2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B23939
                39000000000000000000000000000000090909B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2A0A0
                A0979797979797979797979797979797999999B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000}
            end
            object edtASROCAssign1FC: TEdit
              Left = 11
              Top = 26
              Width = 180
              Height = 21
              TabOrder = 0
            end
            object btnASROCAssign1FC: TButton
              Tag = 1
              Left = 11
              Top = 61
              Width = 58
              Height = 25
              Caption = 'Assign'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              OnClick = btnASROCAssign1FCClick
            end
            object btnASROCDeAssign1FC: TButton
              Tag = 2
              Left = 72
              Top = 61
              Width = 58
              Height = 25
              Caption = 'Cancel'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
              OnClick = btnASROCAssign1FCClick
            end
          end
          object grp6: TGroupBox
            Left = 43
            Top = 312
            Width = 268
            Height = 144
            Caption = 'Status Console'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            DesignSize = (
              268
              144)
            object lbl17: TLabel
              Left = 23
              Top = 28
              Width = 27
              Height = 13
              Anchors = []
              Caption = 'Hydr'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lbl18: TLabel
              Left = 22
              Top = 47
              Width = 54
              Height = 13
              Anchors = []
              Caption = 'Launcher'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lbl19: TLabel
              Left = 21
              Top = 67
              Width = 86
              Height = 13
              Anchors = []
              Caption = 'Launcher Sync'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lbl20: TLabel
              Left = 22
              Top = 86
              Width = 93
              Height = 13
              Anchors = []
              Caption = 'Rocket 1 Ready'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lbl21: TLabel
              Left = 22
              Top = 107
              Width = 93
              Height = 13
              Anchors = []
              Caption = 'Rocket 2 Ready'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object chkASROCHydr: TCheckBox
              Tag = 201
              Left = 133
              Top = 27
              Width = 97
              Height = 17
              Anchors = []
              Checked = True
              State = cbChecked
              TabOrder = 0
            end
            object chkASROCLauncher: TCheckBox
              Tag = 202
              Left = 133
              Top = 45
              Width = 97
              Height = 17
              Anchors = []
              Checked = True
              State = cbChecked
              TabOrder = 1
            end
            object chkASROCLauncherSync: TCheckBox
              Tag = 203
              Left = 132
              Top = 65
              Width = 97
              Height = 17
              Anchors = []
              Checked = True
              State = cbChecked
              TabOrder = 2
            end
            object chkASROCRocket1: TCheckBox
              Tag = 204
              Left = 133
              Top = 83
              Width = 97
              Height = 17
              Anchors = []
              Checked = True
              State = cbChecked
              TabOrder = 3
            end
            object chkASROCRocket2: TCheckBox
              Tag = 205
              Left = 133
              Top = 103
              Width = 97
              Height = 17
              Anchors = []
              Checked = True
              State = cbChecked
              TabOrder = 4
            end
          end
          object grp7: TGroupBox
            Left = 44
            Top = 65
            Width = 268
            Height = 239
            Caption = 'Status Launcher'
            Color = clGray
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 2
            object lblMissileId: TLabel
              Left = 21
              Top = 122
              Width = 39
              Height = 13
              Caption = 'Missile'
            end
            object lblFuze: TLabel
              Left = 21
              Top = 175
              Width = 28
              Height = 13
              Caption = 'Fuze'
            end
            object lblMissileType: TLabel
              Left = 21
              Top = 149
              Width = 71
              Height = 13
              Caption = 'Missile Type'
            end
            object grpLauncher1Asroc: TGroupBox
              Left = 14
              Top = 19
              Width = 241
              Height = 92
              Caption = 'Launcher1'
              Color = clGray
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              TabOrder = 0
              object imgLoadAsrock: TImage
                Left = 48
                Top = 26
                Width = 18
                Height = 17
                Transparent = True
              end
              object imgLoadAsrock2: TImage
                Left = 48
                Top = 56
                Width = 18
                Height = 17
                Transparent = True
              end
              object lblMissile1: TLabel
                Left = 133
                Top = 29
                Width = 39
                Height = 13
                Caption = 'Missile'
              end
              object lblMissile2: TLabel
                Left = 132
                Top = 57
                Width = 39
                Height = 13
                Caption = 'Missile'
              end
            end
            object btnAsrocLoading: TButton
              Tag = 3
              Left = 20
              Top = 201
              Width = 84
              Height = 25
              Caption = 'Load'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              OnClick = btnASROCAssign1FCClick
            end
            object cbbMissileIDstatus: TComboBox
              Left = 147
              Top = 120
              Width = 108
              Height = 22
              Style = csOwnerDrawFixed
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ItemIndex = 0
              ParentFont = False
              TabOrder = 2
              Text = '1'
              Items.Strings = (
                '1'
                '2')
            end
            object cbbMissileType: TComboBox
              Left = 147
              Top = 147
              Width = 108
              Height = 19
              Style = csOwnerDrawFixed
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ItemHeight = 13
              ItemIndex = 0
              ParentFont = False
              TabOrder = 3
              Text = 'Erika'
              Items.Strings = (
                'Erika'
                'Nelly')
            end
            object cbbFuzeType: TComboBox
              Left = 147
              Top = 174
              Width = 108
              Height = 19
              Style = csOwnerDrawFixed
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ItemHeight = 13
              ItemIndex = 0
              ParentFont = False
              TabOrder = 4
              Text = 'Prox'
              Items.Strings = (
                'Prox'
                'Time')
            end
          end
        end
      end
      object rzgrpMistral: TRzGroup
        CaptionFont.Charset = DEFAULT_CHARSET
        CaptionFont.Color = clWindowText
        CaptionFont.Height = -11
        CaptionFont.Name = 'MS Sans Serif'
        CaptionFont.Style = [fsBold]
        Color = clGray
        ColorDefault = False
        Items = <>
        Opened = False
        OpenedHeight = 842
        DividerVisible = False
        Caption = 'MISTRAL'
        ParentColor = False
        Visible = False
        object scrlbxMistral: TScrollBox
          Left = 0
          Top = 20
          Width = 397
          Height = 0
          Align = alClient
          Color = clGray
          ParentColor = False
          TabOrder = 0
          object lbl1: TLabel
            Left = 159
            Top = 11
            Width = 74
            Height = 19
            Caption = 'MISTRAL'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -16
            Font.Name = 'Times New Roman'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object bvl7: TBevel
            Left = 45
            Top = 41
            Width = 268
            Height = 1
          end
          object grp17: TGroupBox
            Left = 44
            Top = 56
            Width = 267
            Height = 297
            Caption = 'Status Launcher'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object grpRightLauncherMistral: TGroupBox
              Left = 47
              Top = 26
              Width = 172
              Height = 111
              Caption = 'Port'
              Color = clGray
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              TabOrder = 0
              object imgLoadMisRight1: TImage
                Left = 32
                Top = 26
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgLoadRightMis2: TImage
                Left = 32
                Top = 62
                Width = 17
                Height = 17
                Transparent = True
              end
              object lbl101: TLabel
                Left = 17
                Top = 28
                Width = 8
                Height = 13
                Caption = '1'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lbl102: TLabel
                Left = 17
                Top = 64
                Width = 8
                Height = 13
                Caption = '2'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object btnMistralLoading: TButton
                Tag = 1
                Left = 81
                Top = 62
                Width = 69
                Height = 22
                Caption = 'Load'
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
                OnClick = btnMistralLoadingClick
              end
              object cbbLoadMisStarboard: TComboBox
                Left = 83
                Top = 27
                Width = 65
                Height = 19
                Style = csOwnerDrawFixed
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ItemHeight = 13
                ItemIndex = 0
                ParentFont = False
                TabOrder = 1
                Text = '1'
                Items.Strings = (
                  '1'
                  '2')
              end
            end
            object grpLeftLauncherMistral: TGroupBox
              Left = 48
              Top = 158
              Width = 170
              Height = 111
              Caption = 'Starboard'
              Color = clGray
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              TabOrder = 1
              object imgLeftMis1: TImage
                Left = 32
                Top = 27
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgLeftMis2: TImage
                Left = 32
                Top = 60
                Width = 17
                Height = 17
                Transparent = True
              end
              object lbl103: TLabel
                Left = 17
                Top = 30
                Width = 8
                Height = 13
                Caption = '1'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lbl104: TLabel
                Left = 16
                Top = 62
                Width = 8
                Height = 13
                Caption = '2'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object btnMistralLoading2: TButton
                Tag = 2
                Left = 76
                Top = 58
                Width = 68
                Height = 22
                Caption = 'Load'
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
                OnClick = btnMistralLoadingClick
              end
              object cbbLoadMisPort: TComboBox
                Left = 76
                Top = 24
                Width = 66
                Height = 19
                Style = csOwnerDrawFixed
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ItemHeight = 13
                ItemIndex = 0
                ParentFont = False
                TabOrder = 1
                Text = '1'
                Items.Strings = (
                  '1'
                  '2')
              end
            end
          end
          object grp18: TGroupBox
            Left = 45
            Top = 368
            Width = 265
            Height = 89
            Caption = 'Status Console'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            object chk1: TCheckBox
              Left = 26
              Top = 27
              Width = 50
              Height = 17
              Caption = 'Port'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
            end
            object chk2: TCheckBox
              Left = 152
              Top = 27
              Width = 89
              Height = 17
              Caption = 'StarBoard'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
            end
          end
        end
      end
      object rzgrpRBU6000: TRzGroup
        CaptionFont.Charset = DEFAULT_CHARSET
        CaptionFont.Color = clWindowText
        CaptionFont.Height = -11
        CaptionFont.Name = 'MS Sans Serif'
        CaptionFont.Style = [fsBold]
        Color = clGray
        ColorDefault = False
        Items = <>
        Opened = False
        OpenedHeight = 842
        DividerVisible = False
        Caption = 'RBU 6000'
        ParentColor = False
        Visible = False
        object scrlbxRBU: TScrollBox
          Left = 0
          Top = 20
          Width = 397
          Height = 943
          Align = alClient
          Color = clGray
          ParentColor = False
          TabOrder = 0
          object lbl23: TLabel
            Left = 159
            Top = 11
            Width = 70
            Height = 19
            Caption = 'RBU 6000'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -16
            Font.Name = 'Times New Roman'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object bvl1: TBevel
            Left = 23
            Top = 41
            Width = 315
            Height = 1
          end
          object AssignRBU6000: TGroupBox
            Left = 22
            Top = 552
            Width = 316
            Height = 105
            Caption = 'Assign RBU 6000'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object btnRBUTrack: TSpeedButton
              Tag = 3
              Left = 198
              Top = 26
              Width = 27
              Height = 22
              Glyph.Data = {
                36090000424D360900000000000036000000280000001F000000180000000100
                18000000000000090000000000000000000000000000000000006161613E3E3E
                3737374040403B3B3B3A3A3A4141414141413A3A3A3A3A3A4040403737373E3E
                3E3D3D3D3838384141413A3A3A3B3B3B4040403737373E3E3E3D3D3D38383841
                41413A3A3A3B3B3B4040403737373E3E3E3C3C3C383838000000B2B2B27C7C7C
                7474747F7F7F7878787777778080808080807878787878788080807474747C7C
                7C7B7B7B7474748080807A7A7A7A7A7A7F7F7F7474747C7C7C7B7B7B74747480
                80807777777979797F7F7F7474747D7D7D7A7A7A757575000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2BDBDBDBBBBBBB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2C0C0C04949
                491111111111111111111212121212121A1A1AB2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B29191914D4D4D5454545F5F
                5F6565656262620000004747476565656363634D4D4D4D4D4D797979BABABAB2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B29797976969692929292929298686
                86B2B2B2ADADAD0000007D7D7DB2B2B2ABABAB292929292929545454979797B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B23D3D3D3B3B3BB2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B26A6A6A0E0E0EB2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B21616166F6F6FA5A5A5B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2AAAAAA94949413
                13138A8A8AB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2030303757575B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2A4A4A400
                0000868686B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2A6A6A68B8B8B2C2C2C838383B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007F7F7FB4B4B4B2B2B2B2B2B2B2B2B2B2B2B2A7A7A727
                27277272729C9C9CB2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000BDBDBDB7B7B7B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD000000888888BBBBBBB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B22C2C2C4C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000B0B0B0B3B3B3B2B2B2B2B2B2BFBFBFB6B6
                B6B2B2B2B1B1B19D9D9DADADADB3B3B3B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3BF
                BFBF3030304C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B0000004F4F4F5151515151515151515858585353
                53737373B2B2B2B2B2B2B2B2B28D8D8D51515151515151515151515152525258
                58581616164C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B0000002424242525252525252525252525252525
                25575757B2B2B2B2B2B2B2B2B27D7D7D25252525252525252525252525252525
                25250909094C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000AFAFAFB2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B22C2C2C4C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000BBBBBBB6B6B6B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD171717848484B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B22C2C2C4C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B29999995F5F5F5A5A5A949494B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B5B5B5B2B2B253
                53535C5C5C828282B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2030303757575B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B7B7B7AFAFAF00
                0000868686B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2030303757575B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2A4A4A400
                0000868686B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B29A9A9A4545454B4B4BB2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B274747423232399
                9999ACACACB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B27A7A7A5A5A5A5555555555559494
                94B5B5B5B4B4B4000000838383B7B7B7ADADAD555555555555585858646464B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B28282822121212121216D6D
                6D9595959898980000006E6E6E9898988B8B8B2121212121215B5B5BB2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B23939
                39000000000000000000000000000000090909B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2A0A0
                A0979797979797979797979797979797999999B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000}
            end
            object btnRBUAssign: TButton
              Tag = 1
              Left = 11
              Top = 61
              Width = 58
              Height = 25
              Caption = 'Assign'
              TabOrder = 0
              OnClick = btnRBUAssignClick
            end
            object edtRBUTrackLabel: TEdit
              Left = 11
              Top = 26
              Width = 180
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
            end
            object btnRbuDeAssign: TButton
              Tag = 2
              Left = 72
              Top = 61
              Width = 58
              Height = 25
              Caption = 'Cancel'
              TabOrder = 2
              OnClick = btnRBUAssignClick
            end
          end
          object grp4: TGroupBox
            Left = 23
            Top = 392
            Width = 313
            Height = 138
            Caption = 'Console Status'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            object lbl79: TLabel
              Left = 22
              Top = 21
              Width = 65
              Height = 13
              Caption = 'Ship Signal'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lbl28: TLabel
              Left = 22
              Top = 42
              Width = 89
              Height = 13
              Caption = 'Unformer 1 Left'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lbl29: TLabel
              Left = 22
              Top = 62
              Width = 89
              Height = 13
              Caption = 'Unformer 2 Left'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lbl30: TLabel
              Left = 22
              Top = 82
              Width = 97
              Height = 13
              Caption = 'Unformer 1 Right'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lbl31: TLabel
              Left = 22
              Top = 101
              Width = 97
              Height = 13
              Caption = 'Unformer 2 Right'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object chkRBUAlirKapal: TCheckBox
              Tag = 305
              Left = 152
              Top = 21
              Width = 25
              Height = 17
              TabOrder = 0
            end
            object chkRBU_Unformer1Left: TCheckBox
              Tag = 306
              Left = 152
              Top = 41
              Width = 25
              Height = 17
              TabOrder = 1
            end
            object chkRBU_Unformer2Left: TCheckBox
              Tag = 307
              Left = 152
              Top = 61
              Width = 25
              Height = 17
              TabOrder = 2
            end
            object chkRBU_Unformer1Right: TCheckBox
              Tag = 308
              Left = 152
              Top = 82
              Width = 25
              Height = 17
              TabOrder = 3
            end
            object chkRBU_Unformer2Right: TCheckBox
              Tag = 309
              Left = 152
              Top = 101
              Width = 25
              Height = 17
              TabOrder = 4
            end
          end
          object grp5: TGroupBox
            Left = 21
            Top = 55
            Width = 316
            Height = 321
            Caption = 'Launcher Status'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            object grp2: TGroupBox
              Left = 21
              Top = 16
              Width = 273
              Height = 137
              Caption = 'Launcher 1 Loading'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              object lbl55: TLabel
                Left = 16
                Top = 22
                Width = 8
                Height = 13
                Caption = '1'
              end
              object lbl56: TLabel
                Left = 73
                Top = 22
                Width = 8
                Height = 13
                Caption = '2'
              end
              object lbl57: TLabel
                Left = 135
                Top = 22
                Width = 8
                Height = 13
                Caption = '3'
              end
              object lbl58: TLabel
                Left = 16
                Top = 52
                Width = 8
                Height = 13
                Caption = '4'
              end
              object lbl59: TLabel
                Left = 74
                Top = 52
                Width = 8
                Height = 13
                Caption = '5'
              end
              object lbl60: TLabel
                Left = 135
                Top = 53
                Width = 8
                Height = 13
                Caption = '6'
              end
              object lbl61: TLabel
                Left = 16
                Top = 80
                Width = 8
                Height = 13
                Caption = '7'
              end
              object lbl62: TLabel
                Left = 73
                Top = 79
                Width = 8
                Height = 13
                Caption = '8'
              end
              object lbl63: TLabel
                Left = 135
                Top = 80
                Width = 8
                Height = 13
                Caption = '9'
              end
              object lbl64: TLabel
                Left = 13
                Top = 107
                Width = 15
                Height = 13
                Caption = '10'
              end
              object lbl65: TLabel
                Left = 70
                Top = 107
                Width = 15
                Height = 13
                Caption = '11'
              end
              object lbl66: TLabel
                Left = 132
                Top = 107
                Width = 15
                Height = 13
                Caption = '12'
              end
              object imgRBU1Load1: TImage
                Left = 46
                Top = 20
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgRBU1Load4: TImage
                Left = 46
                Top = 50
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgRBU1Load7: TImage
                Left = 46
                Top = 79
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgRBU1Load2: TImage
                Left = 105
                Top = 20
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgRBU1Load5: TImage
                Left = 105
                Top = 51
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgRBU1Load8: TImage
                Left = 105
                Top = 78
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgRBU1Load10: TImage
                Left = 46
                Top = 105
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgRBU1Load11: TImage
                Left = 105
                Top = 105
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgRBU1Load3: TImage
                Left = 168
                Top = 21
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgRBU1Load6: TImage
                Left = 168
                Top = 52
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgRBU1Load9: TImage
                Left = 168
                Top = 78
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgRBU1Load12: TImage
                Left = 169
                Top = 105
                Width = 17
                Height = 17
                Transparent = True
              end
              object btn7: TButton
                Tag = 3
                Left = 192
                Top = 104
                Width = 75
                Height = 25
                Caption = 'Load'
                TabOrder = 0
                OnClick = btnRBUAssignClick
              end
            end
            object grp3: TGroupBox
              Left = 21
              Top = 168
              Width = 273
              Height = 137
              Caption = 'Launcher 2 Loading'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              object lbl67: TLabel
                Left = 16
                Top = 22
                Width = 8
                Height = 13
                Caption = '1'
              end
              object lbl68: TLabel
                Left = 76
                Top = 22
                Width = 8
                Height = 13
                Caption = '2'
              end
              object lbl69: TLabel
                Left = 134
                Top = 22
                Width = 8
                Height = 13
                Caption = '3'
              end
              object lbl70: TLabel
                Left = 16
                Top = 52
                Width = 8
                Height = 13
                Caption = '4'
              end
              object lbl71: TLabel
                Left = 77
                Top = 52
                Width = 8
                Height = 13
                Caption = '5'
              end
              object lbl72: TLabel
                Left = 134
                Top = 53
                Width = 8
                Height = 13
                Caption = '6'
              end
              object lbl73: TLabel
                Left = 16
                Top = 80
                Width = 8
                Height = 13
                Caption = '7'
              end
              object lbl74: TLabel
                Left = 76
                Top = 79
                Width = 8
                Height = 13
                Caption = '8'
              end
              object lbl75: TLabel
                Left = 134
                Top = 80
                Width = 8
                Height = 13
                Caption = '9'
              end
              object lbl76: TLabel
                Left = 13
                Top = 107
                Width = 15
                Height = 13
                Caption = '10'
              end
              object lbl77: TLabel
                Left = 73
                Top = 107
                Width = 15
                Height = 13
                Caption = '11'
              end
              object lbl78: TLabel
                Left = 131
                Top = 107
                Width = 15
                Height = 13
                Caption = '12'
              end
              object imgRBU2Load1: TImage
                Left = 44
                Top = 20
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgRBU2Load2: TImage
                Left = 105
                Top = 20
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgRBU2Load3: TImage
                Left = 170
                Top = 20
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgRBU2Load4: TImage
                Left = 44
                Top = 50
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgRBU2Load5: TImage
                Left = 105
                Top = 50
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgRBU2Load6: TImage
                Left = 170
                Top = 51
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgRBU2Load7: TImage
                Left = 44
                Top = 78
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgRBU2Load8: TImage
                Left = 105
                Top = 77
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgRBU2Load9: TImage
                Left = 170
                Top = 78
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgRBU2Load10: TImage
                Left = 45
                Top = 105
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgRBU2Load11: TImage
                Left = 107
                Top = 105
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgRBU2Load12: TImage
                Left = 170
                Top = 104
                Width = 17
                Height = 17
                Transparent = True
              end
              object btn8: TButton
                Tag = 4
                Left = 192
                Top = 104
                Width = 75
                Height = 25
                Caption = 'Load'
                TabOrder = 0
                OnClick = btnRBUAssignClick
              end
            end
          end
        end
      end
      object rzgrpSPS115: TRzGroup
        CaptionFont.Charset = DEFAULT_CHARSET
        CaptionFont.Color = clWindowText
        CaptionFont.Height = -11
        CaptionFont.Name = 'MS Sans Serif'
        CaptionFont.Style = [fsBold]
        Color = clGray
        ColorDefault = False
        Items = <>
        Opened = False
        OpenedHeight = 842
        DividerVisible = False
        Caption = 'SPS115'
        ParentColor = False
        Visible = False
        object scrlbxSPS: TScrollBox
          Left = 0
          Top = 20
          Width = 397
          Height = 30
          Align = alClient
          Color = clGray
          ParentColor = False
          TabOrder = 0
          object lblNameSPS: TLabel
            Left = 159
            Top = 11
            Width = 50
            Height = 19
            Caption = 'SPS115'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -16
            Font.Name = 'Times New Roman'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object bvlSPS: TBevel
            Left = 45
            Top = 41
            Width = 268
            Height = 1
          end
          object GroupBox1: TGroupBox
            Left = 41
            Top = 600
            Width = 274
            Height = 128
            Caption = 'Draw Advice'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object lblMHP: TLabel
              Left = -122
              Top = 97
              Width = 28
              Height = 13
              Caption = 'MHP'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object btnSPSTrack: TSpeedButton
              Tag = -1
              Left = 213
              Top = 26
              Width = 27
              Height = 22
              Glyph.Data = {
                36090000424D360900000000000036000000280000001F000000180000000100
                18000000000000090000000000000000000000000000000000006161613E3E3E
                3737374040403B3B3B3A3A3A4141414141413A3A3A3A3A3A4040403737373E3E
                3E3D3D3D3838384141413A3A3A3B3B3B4040403737373E3E3E3D3D3D38383841
                41413A3A3A3B3B3B4040403737373E3E3E3C3C3C383838000000B2B2B27C7C7C
                7474747F7F7F7878787777778080808080807878787878788080807474747C7C
                7C7B7B7B7474748080807A7A7A7A7A7A7F7F7F7474747C7C7C7B7B7B74747480
                80807777777979797F7F7F7474747D7D7D7A7A7A757575000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2BDBDBDBBBBBBB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2C0C0C04949
                491111111111111111111212121212121A1A1AB2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B29191914D4D4D5454545F5F
                5F6565656262620000004747476565656363634D4D4D4D4D4D797979BABABAB2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B29797976969692929292929298686
                86B2B2B2ADADAD0000007D7D7DB2B2B2ABABAB292929292929545454979797B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B23D3D3D3B3B3BB2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B26A6A6A0E0E0EB2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B21616166F6F6FA5A5A5B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2AAAAAA94949413
                13138A8A8AB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2030303757575B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2A4A4A400
                0000868686B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2A6A6A68B8B8B2C2C2C838383B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007F7F7FB4B4B4B2B2B2B2B2B2B2B2B2B2B2B2A7A7A727
                27277272729C9C9CB2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000BDBDBDB7B7B7B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD000000888888BBBBBBB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B22C2C2C4C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000B0B0B0B3B3B3B2B2B2B2B2B2BFBFBFB6B6
                B6B2B2B2B1B1B19D9D9DADADADB3B3B3B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3BF
                BFBF3030304C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B0000004F4F4F5151515151515151515858585353
                53737373B2B2B2B2B2B2B2B2B28D8D8D51515151515151515151515152525258
                58581616164C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B0000002424242525252525252525252525252525
                25575757B2B2B2B2B2B2B2B2B27D7D7D25252525252525252525252525252525
                25250909094C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000AFAFAFB2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B22C2C2C4C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000BBBBBBB6B6B6B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD171717848484B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B22C2C2C4C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B29999995F5F5F5A5A5A949494B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B5B5B5B2B2B253
                53535C5C5C828282B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2030303757575B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B7B7B7AFAFAF00
                0000868686B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2030303757575B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2A4A4A400
                0000868686B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B29A9A9A4545454B4B4BB2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B274747423232399
                9999ACACACB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B27A7A7A5A5A5A5555555555559494
                94B5B5B5B4B4B4000000838383B7B7B7ADADAD555555555555585858646464B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B28282822121212121216D6D
                6D9595959898980000006E6E6E9898988B8B8B2121212121215B5B5BB2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B23939
                39000000000000000000000000000000090909B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2A0A0
                A0979797979797979797979797979797999999B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000}
            end
            object btnSPSAssign: TButton
              Tag = 1
              Left = 11
              Top = 61
              Width = 96
              Height = 25
              Caption = 'Draw Advice'
              TabOrder = 0
              OnClick = btnSPSAssignClick
            end
            object btnSPSDeAssisgn: TButton
              Tag = 2
              Left = 114
              Top = 60
              Width = 90
              Height = 25
              Caption = 'Cancel'
              TabOrder = 1
              OnClick = btnSPSAssignClick
            end
            object edtSPSTrackLabel: TEdit
              Left = 11
              Top = 26
              Width = 192
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
            end
            object cbbSPSMHP: TComboBox
              Left = 12
              Top = 93
              Width = 82
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ItemIndex = 0
              ParentFont = False
              TabOrder = 3
              Text = 'MHP 50%'
              Items.Strings = (
                'MHP 50%'
                'MHP 80%'
                'MHP 90%')
            end
          end
          object grpLauncher1SPS: TGroupBox
            Left = 45
            Top = 52
            Width = 267
            Height = 141
            Caption = 'Status Launcher'
            Color = clGray
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 1
            object imgLoadSPS1: TImage
              Left = 118
              Top = 30
              Width = 17
              Height = 17
              Transparent = True
            end
            object imgLoadSPS3: TImage
              Left = 118
              Top = 65
              Width = 17
              Height = 17
              Transparent = True
            end
            object imgLoadSPS5: TImage
              Left = 118
              Top = 101
              Width = 17
              Height = 17
              Transparent = True
            end
            object imgLoadSPS2: TImage
              Left = 38
              Top = 30
              Width = 17
              Height = 17
              Transparent = True
            end
            object imgLoadSPS4: TImage
              Left = 38
              Top = 65
              Width = 17
              Height = 17
              Transparent = True
            end
            object imgLoadSPS6: TImage
              Left = 38
              Top = 101
              Width = 17
              Height = 17
              Transparent = True
            end
            object lbl114: TLabel
              Left = 103
              Top = 31
              Width = 8
              Height = 13
              Caption = '1'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lbl115: TLabel
              Left = 103
              Top = 66
              Width = 8
              Height = 13
              Caption = '3'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lbl116: TLabel
              Left = 103
              Top = 102
              Width = 8
              Height = 13
              Caption = '5'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lbl117: TLabel
              Left = 22
              Top = 31
              Width = 8
              Height = 13
              Caption = '2'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lbl118: TLabel
              Left = 22
              Top = 66
              Width = 8
              Height = 13
              Caption = '4'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lbl119: TLabel
              Left = 22
              Top = 102
              Width = 8
              Height = 13
              Caption = '6'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object btnSPS115Loading: TButton
              Tag = 3
              Left = 156
              Top = 94
              Width = 70
              Height = 22
              Caption = 'Load'
              TabOrder = 0
              OnClick = btnSPSAssignClick
            end
            object cbbLoadSPS: TComboBox
              Left = 155
              Top = 65
              Width = 72
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              Text = '1'
              Items.Strings = (
                '1'
                '3'
                '5'
                '2'
                '4'
                '6'
                'All')
            end
          end
          object grpLauncher2SPS: TGroupBox
            Left = 43
            Top = 208
            Width = 270
            Height = 377
            Caption = 'Status Console'
            Color = clGray
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 2
            object lbl6: TLabel
              Left = 22
              Top = 42
              Width = 104
              Height = 13
              Caption = '115V 60HZ Signal'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lbl7: TLabel
              Left = 22
              Top = 64
              Width = 27
              Height = 13
              Caption = 'NDS'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lbl8: TLabel
              Left = 22
              Top = 88
              Width = 49
              Height = 13
              Caption = 'TIU Port'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lbl9: TLabel
              Left = 22
              Top = 111
              Width = 81
              Height = 13
              Caption = 'TIU Starboard'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lbl10: TLabel
              Left = 22
              Top = 134
              Width = 59
              Height = 13
              Caption = 'Temp Port'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lbl15: TLabel
              Left = 22
              Top = 158
              Width = 91
              Height = 13
              Caption = 'Temp Starboard'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lbl11: TLabel
              Left = 22
              Top = 182
              Width = 87
              Height = 13
              Caption = '45 Degree Port'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lbl12: TLabel
              Left = 22
              Top = 205
              Width = 123
              Height = 13
              Caption = '45 Degree Startboard'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lbl13: TLabel
              Left = 22
              Top = 231
              Width = 27
              Height = 13
              Caption = 'Gyro'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblBarrel: TLabel
              Left = 22
              Top = 284
              Width = 37
              Height = 13
              Caption = 'Barrell'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lbl14: TLabel
              Left = 22
              Top = 344
              Width = 44
              Height = 13
              Caption = 'Selftest'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object chkSPSSignal: TCheckBox
              Left = 157
              Top = 42
              Width = 37
              Height = 17
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
            object chkSPSNds: TCheckBox
              Left = 157
              Top = 64
              Width = 18
              Height = 17
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
            object edtSPSTIUPort: TEdit
              Left = 157
              Top = 82
              Width = 70
              Height = 24
              Color = clMenu
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
            object btnSPSSelectTiuPort: TFlatButton
              Left = 229
              Top = 84
              Width = 22
              Height = 21
              Cursor = crHandPoint
              Color = cl3DDkShadow
              ColorFocused = cl3DDkShadow
              ColorDown = cl3DDkShadow
              ColorBorder = clSilver
              ColorHighLight = cl3DDkShadow
              ColorShadow = clSilver
              ParentColor = False
              TabStop = True
              TabOrder = 3
            end
            object edtSPSTIUStartBoard: TEdit
              Left = 157
              Top = 106
              Width = 70
              Height = 24
              Color = clMenu
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
            end
            object btnSPSSelectTIUStartBoard: TFlatButton
              Left = 229
              Top = 108
              Width = 22
              Height = 21
              Cursor = crHandPoint
              Color = cl3DDkShadow
              ColorFocused = cl3DDkShadow
              ColorDown = cl3DDkShadow
              ColorBorder = clSilver
              ColorHighLight = cl3DDkShadow
              ColorShadow = clSilver
              ParentColor = False
              TabStop = True
              TabOrder = 5
            end
            object chkSPSTempPort: TCheckBox
              Left = 157
              Top = 134
              Width = 42
              Height = 17
              TabOrder = 6
            end
            object chkSPSTempStb: TCheckBox
              Left = 157
              Top = 156
              Width = 42
              Height = 17
              TabOrder = 7
            end
            object chkSPSDegreePort: TCheckBox
              Left = 157
              Top = 181
              Width = 42
              Height = 17
              TabOrder = 8
            end
            object chkSPSDegreeStarboard: TCheckBox
              Left = 157
              Top = 203
              Width = 46
              Height = 17
              TabOrder = 9
            end
            object edtSPSGyroNumber: TEdit
              Left = 157
              Top = 226
              Width = 70
              Height = 24
              Color = clMenu
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 10
            end
            object btnSPSSelectGyroNumber: TFlatButton
              Left = 229
              Top = 229
              Width = 22
              Height = 21
              Cursor = crHandPoint
              Color = cl3DDkShadow
              ColorFocused = cl3DDkShadow
              ColorDown = cl3DDkShadow
              ColorBorder = clSilver
              ColorHighLight = cl3DDkShadow
              ColorShadow = clSilver
              ParentColor = False
              TabStop = True
              TabOrder = 11
            end
            object edtSPSGyroval: TEdit
              Left = 157
              Top = 250
              Width = 70
              Height = 24
              Color = clMenu
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 12
            end
            object btnSPSSelectGytoVal: TFlatButton
              Left = 229
              Top = 253
              Width = 22
              Height = 21
              Cursor = crHandPoint
              Color = cl3DDkShadow
              ColorFocused = cl3DDkShadow
              ColorDown = cl3DDkShadow
              ColorBorder = clSilver
              ColorHighLight = cl3DDkShadow
              ColorShadow = clSilver
              ParentColor = False
              TabStop = True
              TabOrder = 13
            end
            object edtSPSBarrelNumber: TEdit
              Left = 157
              Top = 281
              Width = 70
              Height = 24
              Color = clMenu
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 14
            end
            object btnSPSSelectBarrelNumber: TFlatButton
              Left = 229
              Top = 285
              Width = 22
              Height = 21
              Cursor = crHandPoint
              Color = cl3DDkShadow
              ColorFocused = cl3DDkShadow
              ColorDown = cl3DDkShadow
              ColorBorder = clSilver
              ColorHighLight = cl3DDkShadow
              ColorShadow = clSilver
              ParentColor = False
              TabStop = True
              TabOrder = 15
            end
            object edtSPSBarrelVal: TEdit
              Left = 157
              Top = 307
              Width = 70
              Height = 24
              Color = clMenu
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 16
            end
            object btnSPSSelectBarrelVal: TFlatButton
              Left = 229
              Top = 310
              Width = 22
              Height = 21
              Cursor = crHandPoint
              Color = cl3DDkShadow
              ColorFocused = cl3DDkShadow
              ColorDown = cl3DDkShadow
              ColorBorder = clSilver
              ColorHighLight = cl3DDkShadow
              ColorShadow = clSilver
              ParentColor = False
              TabStop = True
              TabOrder = 17
            end
            object chkSPSSelfTest: TCheckBox
              Left = 157
              Top = 346
              Width = 97
              Height = 17
              TabOrder = 18
            end
          end
        end
      end
      object rzgrpMOCsigma: TRzGroup
        CaptionFont.Charset = DEFAULT_CHARSET
        CaptionFont.Color = clWindowText
        CaptionFont.Height = -11
        CaptionFont.Name = 'MS Sans Serif'
        CaptionFont.Style = [fsBold]
        Color = clGray
        ColorDefault = False
        Items = <>
        Opened = False
        OpenedHeight = 842
        DividerVisible = False
        Caption = 'MOC'
        ParentColor = False
        Visible = False
        object scrlbxTOCOSMOC: TScrollBox
          Left = 0
          Top = 20
          Width = 397
          Height = 30
          Align = alClient
          Color = clGray
          ParentColor = False
          TabOrder = 0
          object lbl4: TLabel
            Left = 145
            Top = 11
            Width = 97
            Height = 19
            Caption = 'MOC SIGMA'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -16
            Font.Name = 'Times New Roman'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object bvl11: TBevel
            Left = 45
            Top = 42
            Width = 289
            Height = 1
          end
          object lbl5: TLabel
            Left = 43
            Top = 65
            Width = 118
            Height = 19
            Caption = 'DEVICE SIGMA'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -16
            Font.Name = 'Times New Roman'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object grp1: TGroupBox
            Left = 43
            Top = 87
            Width = 296
            Height = 142
            TabOrder = 0
            object chkMocMW08: TCheckBox
              Tag = 604
              Left = 18
              Top = 50
              Width = 66
              Height = 17
              Caption = 'MW08'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
            end
            object chkMocRadarAPPA: TCheckBox
              Tag = 603
              Left = 18
              Top = 24
              Width = 101
              Height = 19
              Caption = 'Radar ARPA'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
            end
            object chkMocLirodMK2: TCheckBox
              Left = 17
              Top = 81
              Width = 93
              Height = 17
              Caption = 'LIROD MK2'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'Microsoft Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
            end
            object chkMocKingklip: TCheckBox
              Left = 17
              Top = 111
              Width = 105
              Height = 17
              Caption = 'Sonar Kingklip'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'Microsoft Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 3
            end
          end
        end
      end
      object rzgrpExocetMM40: TRzGroup
        CaptionFont.Charset = DEFAULT_CHARSET
        CaptionFont.Color = clWindowText
        CaptionFont.Height = -11
        CaptionFont.Name = 'MS Sans Serif'
        CaptionFont.Style = [fsBold]
        Color = clGray
        ColorDefault = False
        Items = <>
        Opened = False
        OpenedHeight = 842
        DividerVisible = False
        Caption = 'EXOCET MM40'
        ParentColor = False
        Visible = False
        object scrlbxTOCOSExocet40: TScrollBox
          Left = 0
          Top = 20
          Width = 397
          Height = 30
          Align = alClient
          Color = clGray
          ParentColor = False
          TabOrder = 0
          object lbl24: TLabel
            Left = 121
            Top = 11
            Width = 120
            Height = 19
            Caption = 'EXOCET MM 40'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -16
            Font.Name = 'Times New Roman'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object bvl2: TBevel
            Left = 45
            Top = 41
            Width = 268
            Height = 1
          end
          object grpAssignExocetMM40: TGroupBox
            Left = 45
            Top = 482
            Width = 267
            Height = 105
            Caption = 'Assign Exocet MM40'
            TabOrder = 0
            Visible = False
            object btnExocetMM40Track: TSpeedButton
              Left = 198
              Top = 27
              Width = 27
              Height = 22
              Glyph.Data = {
                36090000424D360900000000000036000000280000001F000000180000000100
                18000000000000090000000000000000000000000000000000006161613E3E3E
                3737374040403B3B3B3A3A3A4141414141413A3A3A3A3A3A4040403737373E3E
                3E3D3D3D3838384141413A3A3A3B3B3B4040403737373E3E3E3D3D3D38383841
                41413A3A3A3B3B3B4040403737373E3E3E3C3C3C383838000000B2B2B27C7C7C
                7474747F7F7F7878787777778080808080807878787878788080807474747C7C
                7C7B7B7B7474748080807A7A7A7A7A7A7F7F7F7474747C7C7C7B7B7B74747480
                80807777777979797F7F7F7474747D7D7D7A7A7A757575000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2BDBDBDBBBBBBB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2C0C0C04949
                491111111111111111111212121212121A1A1AB2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B29191914D4D4D5454545F5F
                5F6565656262620000004747476565656363634D4D4D4D4D4D797979BABABAB2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B29797976969692929292929298686
                86B2B2B2ADADAD0000007D7D7DB2B2B2ABABAB292929292929545454979797B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B23D3D3D3B3B3BB2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B26A6A6A0E0E0EB2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B21616166F6F6FA5A5A5B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2AAAAAA94949413
                13138A8A8AB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2030303757575B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2A4A4A400
                0000868686B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2A6A6A68B8B8B2C2C2C838383B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007F7F7FB4B4B4B2B2B2B2B2B2B2B2B2B2B2B2A7A7A727
                27277272729C9C9CB2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000BDBDBDB7B7B7B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD000000888888BBBBBBB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B22C2C2C4C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000B0B0B0B3B3B3B2B2B2B2B2B2BFBFBFB6B6
                B6B2B2B2B1B1B19D9D9DADADADB3B3B3B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3BF
                BFBF3030304C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B0000004F4F4F5151515151515151515858585353
                53737373B2B2B2B2B2B2B2B2B28D8D8D51515151515151515151515152525258
                58581616164C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B0000002424242525252525252525252525252525
                25575757B2B2B2B2B2B2B2B2B27D7D7D25252525252525252525252525252525
                25250909094C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000AFAFAFB2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B22C2C2C4C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000BBBBBBB6B6B6B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD171717848484B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B22C2C2C4C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B29999995F5F5F5A5A5A949494B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B5B5B5B2B2B253
                53535C5C5C828282B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2030303757575B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B7B7B7AFAFAF00
                0000868686B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2030303757575B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2A4A4A400
                0000868686B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B29A9A9A4545454B4B4BB2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B274747423232399
                9999ACACACB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B27A7A7A5A5A5A5555555555559494
                94B5B5B5B4B4B4000000838383B7B7B7ADADAD555555555555585858646464B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B28282822121212121216D6D
                6D9595959898980000006E6E6E9898988B8B8B2121212121215B5B5BB2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B23939
                39000000000000000000000000000000090909B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2A0A0
                A0979797979797979797979797979797999999B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000}
            end
            object edtExocetMM40Track: TEdit
              Left = 11
              Top = 26
              Width = 180
              Height = 21
              TabOrder = 0
            end
            object btnExocetMM40Assign: TButton
              Tag = 1
              Left = 11
              Top = 61
              Width = 58
              Height = 25
              Caption = 'Assign'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
            end
            object btnExocetMM40DeAssign: TButton
              Tag = 2
              Left = 71
              Top = 60
              Width = 58
              Height = 25
              Caption = 'Cancel'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
            end
          end
          object grp10: TGroupBox
            Left = 46
            Top = 64
            Width = 265
            Height = 249
            Caption = 'Status Launcher'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            object grpRightLauncherExocet: TGroupBox
              Left = 43
              Top = 22
              Width = 177
              Height = 99
              Caption = 'StarBoard'
              Color = clGray
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              TabOrder = 0
              object imgLoadExoRight1: TImage
                Left = 40
                Top = 17
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgLoadExoRight2: TImage
                Left = 40
                Top = 48
                Width = 17
                Height = 17
                Transparent = True
              end
              object lbl88: TLabel
                Left = 23
                Top = 19
                Width = 8
                Height = 13
                Caption = '1'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lbl89: TLabel
                Left = 23
                Top = 50
                Width = 8
                Height = 13
                Caption = '2'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object btnExocet40Loading2: TButton
                Left = 93
                Top = 72
                Width = 76
                Height = 22
                Caption = 'Load'
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
                OnClick = btnExocet40LoadingClick
              end
              object cbbLoadExoStarboard: TComboBox
                Left = 11
                Top = 72
                Width = 73
                Height = 21
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ItemIndex = 0
                ParentFont = False
                TabOrder = 1
                Text = '1'
                Items.Strings = (
                  '1'
                  '2')
              end
            end
            object grpRightLauncherExocet2: TGroupBox
              Left = 41
              Top = 129
              Width = 179
              Height = 99
              Caption = 'Port'
              Color = clGray
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              TabOrder = 1
              object imgLoadExoLeft1: TImage
                Left = 40
                Top = 16
                Width = 17
                Height = 17
                Transparent = True
              end
              object imgLoadExoLeft2: TImage
                Left = 40
                Top = 45
                Width = 17
                Height = 17
                Transparent = True
              end
              object lbl90: TLabel
                Left = 23
                Top = 18
                Width = 8
                Height = 13
                Caption = '1'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lbl91: TLabel
                Left = 23
                Top = 47
                Width = 8
                Height = 13
                Caption = '2'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object btn2Exocet40Loading2: TButton
                Tag = 1
                Left = 96
                Top = 72
                Width = 74
                Height = 22
                Caption = 'Load'
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
                OnClick = btnExocet40LoadingClick
              end
              object cbbLoadExoPort: TComboBox
                Left = 13
                Top = 72
                Width = 73
                Height = 21
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ItemIndex = 0
                ParentFont = False
                TabOrder = 1
                Text = '1'
                Items.Strings = (
                  '1'
                  '2')
              end
            end
          end
          object grp11: TGroupBox
            Left = 46
            Top = 344
            Width = 266
            Height = 108
            Caption = 'Status Console'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            object chkExocet40: TCheckBox
              Left = 45
              Top = 27
              Width = 162
              Height = 17
              Caption = 'Enable Exocet MM40'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
            object chkSafetyFA: TCheckBox
              Left = 62
              Top = 52
              Width = 162
              Height = 17
              Caption = 'Safety Panel-FA'
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
            object chkControlFA: TCheckBox
              Left = 62
              Top = 71
              Width = 162
              Height = 17
              Caption = 'Control Panel-FA'
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
          end
        end
      end
      object rzgrpCannon76: TRzGroup
        CaptionFont.Charset = DEFAULT_CHARSET
        CaptionFont.Color = clWindowText
        CaptionFont.Height = -11
        CaptionFont.Name = 'MS Sans Serif'
        CaptionFont.Style = [fsBold]
        Color = clGray
        ColorDefault = False
        Items = <>
        Opened = False
        OpenedHeight = 842
        DividerVisible = False
        Caption = 'CANNON 76'
        ParentColor = False
        Visible = False
        object scrlbxCannon76: TScrollBox
          Left = 0
          Top = 20
          Width = 397
          Height = 30
          Align = alClient
          Color = clGray
          ParentColor = False
          TabOrder = 0
          object lblCannon76: TLabel
            Left = 146
            Top = 11
            Width = 90
            Height = 19
            Caption = 'CANNON 76'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -16
            Font.Name = 'Times New Roman'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object bvl10: TBevel
            Left = 45
            Top = 41
            Width = 268
            Height = 1
          end
          object chkCannon76: TCheckBox
            Tag = 601
            Left = 46
            Top = 65
            Width = 137
            Height = 17
            Caption = 'Enable Cannon76'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
          object grpCannon76Assign: TGroupBox
            Left = 47
            Top = 110
            Width = 268
            Height = 105
            Caption = 'Assign Cannon76'
            TabOrder = 1
            object btnCannon76Track: TSpeedButton
              Left = 198
              Top = 27
              Width = 27
              Height = 22
              Glyph.Data = {
                36090000424D360900000000000036000000280000001F000000180000000100
                18000000000000090000000000000000000000000000000000006161613E3E3E
                3737374040403B3B3B3A3A3A4141414141413A3A3A3A3A3A4040403737373E3E
                3E3D3D3D3838384141413A3A3A3B3B3B4040403737373E3E3E3D3D3D38383841
                41413A3A3A3B3B3B4040403737373E3E3E3C3C3C383838000000B2B2B27C7C7C
                7474747F7F7F7878787777778080808080807878787878788080807474747C7C
                7C7B7B7B7474748080807A7A7A7A7A7A7F7F7F7474747C7C7C7B7B7B74747480
                80807777777979797F7F7F7474747D7D7D7A7A7A757575000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2BDBDBDBBBBBBB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2C0C0C04949
                491111111111111111111212121212121A1A1AB2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B29191914D4D4D5454545F5F
                5F6565656262620000004747476565656363634D4D4D4D4D4D797979BABABAB2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B29797976969692929292929298686
                86B2B2B2ADADAD0000007D7D7DB2B2B2ABABAB292929292929545454979797B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B23D3D3D3B3B3BB2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B26A6A6A0E0E0EB2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B21616166F6F6FA5A5A5B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2AAAAAA94949413
                13138A8A8AB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2030303757575B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2A4A4A400
                0000868686B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2A6A6A68B8B8B2C2C2C838383B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007F7F7FB4B4B4B2B2B2B2B2B2B2B2B2B2B2B2A7A7A727
                27277272729C9C9CB2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000BDBDBDB7B7B7B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD000000888888BBBBBBB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B22C2C2C4C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000B0B0B0B3B3B3B2B2B2B2B2B2BFBFBFB6B6
                B6B2B2B2B1B1B19D9D9DADADADB3B3B3B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3BF
                BFBF3030304C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B0000004F4F4F5151515151515151515858585353
                53737373B2B2B2B2B2B2B2B2B28D8D8D51515151515151515151515152525258
                58581616164C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B0000002424242525252525252525252525252525
                25575757B2B2B2B2B2B2B2B2B27D7D7D25252525252525252525252525252525
                25250909094C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000AFAFAFB2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B22C2C2C4C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B27B7B7B000000BBBBBBB6B6B6B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD171717848484B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B22C2C2C4C4C4CB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B29999995F5F5F5A5A5A949494B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B5B5B5B2B2B253
                53535C5C5C828282B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2030303757575B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B7B7B7AFAFAF00
                0000868686B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2030303757575B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2A4A4A400
                0000868686B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B29A9A9A4545454B4B4BB2B2B2B2B2B2B2B2
                B2B2B2B2ADADAD0000007D7D7DB2B2B2B2B2B2B2B2B2B2B2B274747423232399
                9999ACACACB2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B27A7A7A5A5A5A5555555555559494
                94B5B5B5B4B4B4000000838383B7B7B7ADADAD555555555555585858646464B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B3B3B3000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B28282822121212121216D6D
                6D9595959898980000006E6E6E9898988B8B8B2121212121215B5B5BB2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B23939
                39000000000000000000000000000000090909B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B4B4B4000000D0D0D0B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2A0A0
                A0979797979797979797979797979797999999B2B2B2B2B2B2B2B2B2B2B2B2B2
                B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2B2000000}
            end
            object edtCannon76Track: TEdit
              Left = 11
              Top = 26
              Width = 180
              Height = 21
              TabOrder = 0
            end
            object btnCannon76Assign: TButton
              Tag = 1
              Left = 11
              Top = 61
              Width = 58
              Height = 25
              Caption = 'Assign'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
            end
            object btnCannon76DeAssign: TButton
              Tag = 2
              Left = 73
              Top = 61
              Width = 58
              Height = 25
              Caption = 'Cancel'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
            end
            object btnCannon76Loading: TButton
              Tag = 3
              Left = 133
              Top = 61
              Width = 58
              Height = 25
              Caption = 'Loading'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 3
            end
          end
        end
      end
      object rzgrpCannon57: TRzGroup
        CaptionFont.Charset = DEFAULT_CHARSET
        CaptionFont.Color = clWindowText
        CaptionFont.Height = -11
        CaptionFont.Name = 'MS Sans Serif'
        CaptionFont.Style = [fsBold]
        Color = clGray
        ColorDefault = False
        Items = <>
        Opened = False
        OpenedHeight = 842
        DividerVisible = False
        Caption = 'CANNON 57'
        ParentColor = False
        Visible = False
        object scrlbxCannon57: TScrollBox
          Left = 0
          Top = 20
          Width = 397
          Height = 30
          Align = alClient
          Color = clGray
          ParentColor = False
          TabOrder = 0
          object lbl3: TLabel
            Left = 146
            Top = 11
            Width = 90
            Height = 19
            Caption = 'CANNON 57'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -16
            Font.Name = 'Times New Roman'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object bvl9: TBevel
            Left = 45
            Top = 41
            Width = 268
            Height = 1
          end
          object chkCannon57enableWeaphon: TCheckBox
            Tag = 601
            Left = 45
            Top = 65
            Width = 137
            Height = 17
            Caption = 'Enable Cannon'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
        end
      end
    end
    object pnlBlank: TPanel
      Left = 397
      Top = 0
      Width = 1
      Height = 963
      Align = alClient
      BevelOuter = bvLowered
      Color = 7301478
      TabOrder = 1
    end
  end
  object pmSPSGyroVal: TPopupMenu
    Left = 744
    Top = 104
    object Normal1: TMenuItem
      Tag = 1
      Caption = 'Normal'
      OnClick = Normal1Click
    end
    object ooLongGyroCagingTime1: TMenuItem
      Tag = 2
      Caption = 'Too Long Gyro Caging Time'
      OnClick = Normal1Click
    end
    object GyroStartingOverloaded1: TMenuItem
      Tag = 3
      Caption = 'Gyro Starting Overloaded'
      OnClick = Normal1Click
    end
    object ooLongGyroStarting1: TMenuItem
      Tag = 4
      Caption = 'Too Long Gyro Starting'
      OnClick = Normal1Click
    end
    object NoLinkWithTIU1: TMenuItem
      Tag = 5
      Caption = 'No Link With TIU'
      OnClick = Normal1Click
    end
  end
  object pmSPSTIUPort: TPopupMenu
    Left = 743
    Top = 136
    object Normal4: TMenuItem
      Caption = 'Normal'
      OnClick = Normal4Click
    end
    object Faulty1: TMenuItem
      Tag = 1
      Caption = 'Faulty'
      OnClick = Normal4Click
    end
    object lowVoltage1: TMenuItem
      Tag = 2
      Caption = 'Low Voltage'
      OnClick = Normal4Click
    end
    object NoLink1: TMenuItem
      Tag = 3
      Caption = 'No Link'
      OnClick = Normal4Click
    end
  end
  object pmSPSTIUStarBoard: TPopupMenu
    Left = 743
    Top = 168
    object Normal3: TMenuItem
      Caption = 'Normal'
      OnClick = Normal3Click
    end
    object Faulty2: TMenuItem
      Tag = 1
      Caption = 'Faulty'
      OnClick = Normal3Click
    end
    object LowVoltage2: TMenuItem
      Tag = 2
      Caption = 'Low Voltage'
      OnClick = Normal3Click
    end
    object NoLink2: TMenuItem
      Tag = 3
      Caption = 'No Link'
      OnClick = Normal3Click
    end
  end
  object pmSPSBarrelValue: TPopupMenu
    Left = 743
    Top = 72
    object Normal2: TMenuItem
      Tag = 1
      Caption = 'Normal'
      OnClick = Normal2Click
    end
    object UntimelyStartingTime1: TMenuItem
      Tag = 2
      Caption = 'Untimely Starting Time'
      OnClick = Normal2Click
    end
    object BarrelNoLongerReady1: TMenuItem
      Tag = 3
      Caption = 'Barrel No Longer Ready'
      OnClick = Normal2Click
    end
    object AbsenceOfGyro1: TMenuItem
      Tag = 4
      Caption = 'Absence Of Gyro'
      OnClick = Normal2Click
    end
    object ErrorWritingTorpedo1: TMenuItem
      Tag = 5
      Caption = 'Error Writing Torpedo'
      OnClick = Normal2Click
    end
    object ExerciseHeadNotStart1: TMenuItem
      Tag = 6
      Caption = 'Exercise Head Not Start'
      OnClick = Normal2Click
    end
    object orpedoNotLeaveBarrelinFire1: TMenuItem
      Tag = 7
      Caption = 'Torpedo Not Leave Barrel in Fire'
      OnClick = Normal2Click
    end
  end
  object tmrLoading: TTimer
    Enabled = False
    OnTimer = tmrLoadingTimer
    Left = 301
    Top = 592
  end
end
