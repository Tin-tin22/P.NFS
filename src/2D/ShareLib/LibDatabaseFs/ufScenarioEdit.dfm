object frmSceEditor: TfrmSceEditor
  Left = 1750
  Top = 113
  Caption = 'Scenario Editor'
  ClientHeight = 628
  ClientWidth = 1208
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 1208
    Height = 628
    Align = alClient
    Color = clGray
    ParentBackground = False
    TabOrder = 0
    OnClick = pnlMainClick
    object lbl1: TLabel
      Left = 16
      Top = 16
      Width = 87
      Height = 16
      Caption = 'Scenario Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 16
      Top = 40
      Width = 63
      Height = 16
      Caption = 'Description'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Port: TLabel
      Left = 16
      Top = 136
      Width = 23
      Height = 16
      Caption = 'Port'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object mmoKetSce: TMemo
      Left = 104
      Top = 43
      Width = 553
      Height = 81
      Lines.Strings = (
        '')
      TabOrder = 0
    end
    object edtScenarioName: TEdit
      Left = 104
      Top = 16
      Width = 209
      Height = 21
      TabOrder = 1
    end
    object pgcShip: TAdvPageControl
      Left = 15
      Top = 208
      Width = 1186
      Height = 361
      ActivePage = tsWarShip
      ActiveFont.Charset = DEFAULT_CHARSET
      ActiveFont.Color = clWhite
      ActiveFont.Height = -13
      ActiveFont.Name = 'Tahoma'
      ActiveFont.Style = [fsBold]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      DefaultTabColor = clGray
      DefaultTabColorTo = clWhite
      ActiveColor = clGray
      TabBackGroundColor = clBtnFace
      TabMargin.RightMargin = 0
      TabOverlap = 0
      TabStyle = tsDotNet
      Version = '1.7.1.0'
      TabOrder = 2
      TabWidth = 150
      object tsWarShip: TAdvTabSheet
        Caption = 'Ship Configuration'
        Color = clGray
        ColorTo = clNone
        ImageIndex = 1
        TabColor = clGray
        TabColorTo = clWhite
        object lbl3: TLabel
          Left = 5
          Top = 8
          Width = 59
          Height = 16
          Caption = 'Available'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbl4: TLabel
          Left = 395
          Top = 8
          Width = 56
          Height = 16
          Caption = 'Selected'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbl8: TLabel
          Left = 851
          Top = 8
          Width = 113
          Height = 16
          Caption = 'Weapon Selected'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lvWarShipAll: TListView
          Left = 4
          Top = 30
          Width = 238
          Height = 286
          Columns = <
            item
              Caption = 'ID'
            end
            item
              Caption = 'Ship Name'
              Width = 150
            end
            item
              Caption = 'No'
            end
            item
              Caption = 'Ctgr'
            end>
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          GridLines = True
          MultiSelect = True
          ReadOnly = True
          RowSelect = True
          ParentFont = False
          SortType = stBoth
          TabOrder = 0
          ViewStyle = vsReport
          OnClick = lvWarShipAllClick
          OnCompare = lvWarShipAllCompare
          OnDblClick = lvWarShipAllDblClick
          OnSelectItem = lvWarShipAllSelectItem
        end
        object lvWarShipSelect: TListView
          Left = 395
          Top = 30
          Width = 438
          Height = 286
          Columns = <
            item
              Caption = 'ID'
            end
            item
              Caption = 'Ship Name'
              Width = 100
            end
            item
              Caption = 'No'
            end
            item
              Caption = 'Ctgr'
            end
            item
              Caption = 'X Coord'
              Width = 100
            end
            item
              Caption = 'Y Coord'
              Width = 100
            end
            item
              Caption = 'Z Coord'
              Width = 100
            end
            item
              Caption = 'Heading'
            end>
          GridLines = True
          MultiSelect = True
          RowSelect = True
          SortType = stBoth
          TabOrder = 1
          ViewStyle = vsReport
          OnClick = lvWarShipSelectClick
          OnCompare = lvWarShipSelectCompare
          OnDblClick = lvWarShipSelectDblClick
          OnSelectItem = lvWarShipSelectSelectItem
        end
        object btnAddWarShip: TAdvSmoothButton
          Left = 264
          Top = 48
          Width = 113
          Height = 33
          Appearance.Font.Charset = DEFAULT_CHARSET
          Appearance.Font.Color = clWhite
          Appearance.Font.Height = -13
          Appearance.Font.Name = 'Tahoma'
          Appearance.Font.Style = [fsBold]
          Status.Caption = '0'
          Status.Appearance.Fill.Color = clRed
          Status.Appearance.Fill.ColorMirror = clNone
          Status.Appearance.Fill.ColorMirrorTo = clNone
          Status.Appearance.Fill.GradientType = gtSolid
          Status.Appearance.Fill.BorderColor = clGray
          Status.Appearance.Fill.Rounding = 0
          Status.Appearance.Fill.ShadowOffset = 0
          Status.Appearance.Fill.Glow = gmNone
          Status.Appearance.Font.Charset = DEFAULT_CHARSET
          Status.Appearance.Font.Color = clWhite
          Status.Appearance.Font.Height = -11
          Status.Appearance.Font.Name = 'Tahoma'
          Status.Appearance.Font.Style = []
          BevelColor = clGray
          Caption = '>>'
          Color = clBlack
          ParentFont = False
          TabOrder = 2
          Version = '1.6.9.4'
          OnClick = btnAddWarShipClick
        end
        object btnRemoveWarShip: TAdvSmoothButton
          Left = 264
          Top = 84
          Width = 113
          Height = 33
          Appearance.Font.Charset = DEFAULT_CHARSET
          Appearance.Font.Color = clWhite
          Appearance.Font.Height = -13
          Appearance.Font.Name = 'Tahoma'
          Appearance.Font.Style = [fsBold]
          Status.Caption = '0'
          Status.Appearance.Fill.Color = clRed
          Status.Appearance.Fill.ColorMirror = clNone
          Status.Appearance.Fill.ColorMirrorTo = clNone
          Status.Appearance.Fill.GradientType = gtSolid
          Status.Appearance.Fill.BorderColor = clGray
          Status.Appearance.Fill.Rounding = 0
          Status.Appearance.Fill.ShadowOffset = 0
          Status.Appearance.Fill.Glow = gmNone
          Status.Appearance.Font.Charset = DEFAULT_CHARSET
          Status.Appearance.Font.Color = clWhite
          Status.Appearance.Font.Height = -11
          Status.Appearance.Font.Name = 'Tahoma'
          Status.Appearance.Font.Style = []
          BevelColor = clGray
          Caption = '<<'
          Color = clBlack
          ParentFont = False
          TabOrder = 3
          Version = '1.6.9.4'
          OnClick = btnRemoveWarShipClick
        end
        object btnWeaponList: TAdvSmoothButton
          Left = 262
          Top = 283
          Width = 115
          Height = 33
          Cursor = crHandPoint
          Appearance.Font.Charset = DEFAULT_CHARSET
          Appearance.Font.Color = clWhite
          Appearance.Font.Height = -13
          Appearance.Font.Name = 'Tahoma'
          Appearance.Font.Style = [fsBold]
          Status.Caption = '0'
          Status.Appearance.Fill.Color = clRed
          Status.Appearance.Fill.ColorMirror = clNone
          Status.Appearance.Fill.ColorMirrorTo = clNone
          Status.Appearance.Fill.GradientType = gtSolid
          Status.Appearance.Fill.BorderColor = clGray
          Status.Appearance.Fill.Rounding = 0
          Status.Appearance.Fill.ShadowOffset = 0
          Status.Appearance.Fill.Glow = gmNone
          Status.Appearance.Font.Charset = DEFAULT_CHARSET
          Status.Appearance.Font.Color = clWhite
          Status.Appearance.Font.Height = -11
          Status.Appearance.Font.Name = 'Tahoma'
          Status.Appearance.Font.Style = []
          BevelColor = clGray
          Caption = 'Weapon Editor'
          Color = clBlack
          ParentFont = False
          TabOrder = 4
          Visible = False
          Version = '1.6.9.4'
          OnClick = btnWeaponListClick
        end
        object lvWeaponSelected: TListView
          Left = 848
          Top = 30
          Width = 313
          Height = 233
          Columns = <
            item
              Caption = 'ID'
            end
            item
              Caption = 'Weapon Name'
              Width = 100
            end
            item
              Caption = 'Launcher'
            end
            item
              Caption = 'Enable'
              Width = 100
            end>
          GridLines = True
          RowSelect = True
          TabOrder = 5
          ViewStyle = vsReport
          OnClick = lvWeaponSelectedClick
        end
        object btnEnableWeapon: TAdvSmoothButton
          Left = 1035
          Top = 289
          Width = 127
          Height = 33
          Cursor = crHandPoint
          Appearance.Font.Charset = DEFAULT_CHARSET
          Appearance.Font.Color = clWhite
          Appearance.Font.Height = -13
          Appearance.Font.Name = 'Tahoma'
          Appearance.Font.Style = [fsBold]
          Status.Caption = '0'
          Status.Appearance.Fill.Color = clRed
          Status.Appearance.Fill.ColorMirror = clNone
          Status.Appearance.Fill.ColorMirrorTo = clNone
          Status.Appearance.Fill.GradientType = gtSolid
          Status.Appearance.Fill.BorderColor = clGray
          Status.Appearance.Fill.Rounding = 0
          Status.Appearance.Fill.ShadowOffset = 0
          Status.Appearance.Fill.Glow = gmNone
          Status.Appearance.Font.Charset = DEFAULT_CHARSET
          Status.Appearance.Font.Color = clWhite
          Status.Appearance.Font.Height = -11
          Status.Appearance.Font.Name = 'Tahoma'
          Status.Appearance.Font.Style = []
          BevelColor = clGray
          Caption = 'Enable'
          Color = clBlack
          ParentFont = False
          TabOrder = 6
          Version = '1.6.9.4'
          OnClick = btnEnableWeaponClick
        end
        object btnShipEditor: TAdvSmoothButton
          Left = 262
          Top = 246
          Width = 115
          Height = 33
          Cursor = crHandPoint
          Appearance.Font.Charset = DEFAULT_CHARSET
          Appearance.Font.Color = clWhite
          Appearance.Font.Height = -13
          Appearance.Font.Name = 'Tahoma'
          Appearance.Font.Style = [fsBold]
          Status.Caption = '0'
          Status.Appearance.Fill.Color = clRed
          Status.Appearance.Fill.ColorMirror = clNone
          Status.Appearance.Fill.ColorMirrorTo = clNone
          Status.Appearance.Fill.GradientType = gtSolid
          Status.Appearance.Fill.BorderColor = clGray
          Status.Appearance.Fill.Rounding = 0
          Status.Appearance.Fill.ShadowOffset = 0
          Status.Appearance.Fill.Glow = gmNone
          Status.Appearance.Font.Charset = DEFAULT_CHARSET
          Status.Appearance.Font.Color = clWhite
          Status.Appearance.Font.Height = -11
          Status.Appearance.Font.Name = 'Tahoma'
          Status.Appearance.Font.Style = []
          BevelColor = clGray
          Caption = 'Ship Editor'
          Color = clBlack
          ParentFont = False
          TabOrder = 7
          Visible = False
          Version = '1.6.9.4'
        end
      end
      object tsGeneralShip: TAdvTabSheet
        Caption = 'General Ship'
        Color = clGray
        ColorTo = clNone
        TabColor = clGray
        TabColorTo = clWhite
        object lbl5: TLabel
          Left = 5
          Top = 8
          Width = 59
          Height = 16
          Caption = 'Available'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbl6: TLabel
          Left = 395
          Top = 8
          Width = 56
          Height = 16
          Caption = 'Selected'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lvGeneralShipAll: TListView
          Left = 3
          Top = 30
          Width = 238
          Height = 286
          Columns = <
            item
              Caption = 'ID'
            end
            item
              Caption = 'Ship Name'
              Width = 150
            end
            item
              Caption = 'Ctgr'
            end>
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          GridLines = True
          MultiSelect = True
          RowSelect = True
          ParentFont = False
          TabOrder = 0
          ViewStyle = vsReport
          OnClick = lvGeneralShipAllClick
          OnCompare = lvGeneralShipAllCompare
          OnDblClick = lvGeneralShipAllDblClick
          OnSelectItem = lvGeneralShipAllSelectItem
        end
        object lvGeneralShipSelect: TListView
          Left = 395
          Top = 30
          Width = 774
          Height = 286
          Columns = <
            item
              Caption = 'ID'
            end
            item
              Caption = 'Ship Name'
              Width = 100
            end
            item
              Caption = 'Ctgr'
            end
            item
              Caption = 'X Coord'
              Width = 100
            end
            item
              Caption = 'Y Coord'
              Width = 100
            end
            item
              Caption = 'Z Coord'
              Width = 100
            end
            item
              Caption = 'Heading'
              Width = 100
            end>
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          GridLines = True
          MultiSelect = True
          RowSelect = True
          ParentFont = False
          TabOrder = 1
          ViewStyle = vsReport
          OnClick = lvGeneralShipSelectClick
          OnCompare = lvGeneralShipSelectCompare
          OnDblClick = lvGeneralShipSelectDblClick
          OnSelectItem = lvGeneralShipSelectSelectItem
        end
        object btnAddGnrShip: TAdvSmoothButton
          Left = 264
          Top = 49
          Width = 113
          Height = 33
          Cursor = crHandPoint
          Appearance.Font.Charset = DEFAULT_CHARSET
          Appearance.Font.Color = clWhite
          Appearance.Font.Height = -13
          Appearance.Font.Name = 'Tahoma'
          Appearance.Font.Style = [fsBold]
          Status.Caption = '0'
          Status.Appearance.Fill.Color = clRed
          Status.Appearance.Fill.ColorMirror = clNone
          Status.Appearance.Fill.ColorMirrorTo = clNone
          Status.Appearance.Fill.GradientType = gtSolid
          Status.Appearance.Fill.BorderColor = clGray
          Status.Appearance.Fill.Rounding = 0
          Status.Appearance.Fill.ShadowOffset = 0
          Status.Appearance.Fill.Glow = gmNone
          Status.Appearance.Font.Charset = DEFAULT_CHARSET
          Status.Appearance.Font.Color = clWhite
          Status.Appearance.Font.Height = -11
          Status.Appearance.Font.Name = 'Tahoma'
          Status.Appearance.Font.Style = []
          BevelColor = clGray
          Caption = '>>'
          Color = clBlack
          ParentFont = False
          TabOrder = 2
          Version = '1.6.9.4'
          OnClick = btnAddGnrShipClick
        end
        object btnRemoveGnrShip: TAdvSmoothButton
          Left = 265
          Top = 85
          Width = 112
          Height = 34
          Cursor = crHandPoint
          Appearance.Font.Charset = DEFAULT_CHARSET
          Appearance.Font.Color = clWhite
          Appearance.Font.Height = -13
          Appearance.Font.Name = 'Tahoma'
          Appearance.Font.Style = [fsBold]
          Status.Caption = '0'
          Status.Appearance.Fill.Color = clRed
          Status.Appearance.Fill.ColorMirror = clNone
          Status.Appearance.Fill.ColorMirrorTo = clNone
          Status.Appearance.Fill.GradientType = gtSolid
          Status.Appearance.Fill.BorderColor = clGray
          Status.Appearance.Fill.Rounding = 0
          Status.Appearance.Fill.ShadowOffset = 0
          Status.Appearance.Fill.Glow = gmNone
          Status.Appearance.Font.Charset = DEFAULT_CHARSET
          Status.Appearance.Font.Color = clWhite
          Status.Appearance.Font.Height = -11
          Status.Appearance.Font.Name = 'Tahoma'
          Status.Appearance.Font.Style = []
          BevelColor = clGray
          Caption = '<<'
          Color = clBlack
          ParentFont = False
          TabOrder = 3
          Version = '1.6.9.4'
          OnClick = btnRemoveGnrShipClick
        end
      end
      object tsConsoleList: TAdvTabSheet
        Caption = 'Console Scenario'
        Color = clGray
        ColorTo = clNone
        TabColor = clGray
        TabColorTo = clWhite
        object lbl7: TLabel
          Left = 0
          Top = 12
          Width = 50
          Height = 16
          Caption = 'Console'
        end
        object lvConsole: TListView
          Left = 0
          Top = 34
          Width = 1169
          Height = 279
          Columns = <
            item
              Caption = 'ID'
            end
            item
              Caption = 'CUBICLE'
              Width = 150
            end
            item
              Caption = 'CONSOLE'
              Width = 250
            end
            item
              Caption = 'TYPE'
            end
            item
              Caption = 'IP'
              Width = 300
            end
            item
              Caption = 'SHIP'
              Width = 125
            end
            item
              Caption = 'SHIPID'
              Width = 75
            end
            item
              Caption = 'LAUNCHERID'
              Width = 100
            end>
          GridLines = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          OnDblClick = lvConsoleDblClick
          OnMouseDown = lvConsoleMouseDown
        end
      end
    end
    object cbbPort: TComboBox
      Left = 104
      Top = 133
      Width = 209
      Height = 21
      TabOrder = 5
      Text = 'Surabaya'
      OnCloseUp = cbbPortCloseUp
      Items.Strings = (
        'Surabaya'
        'Jakarta'
        'Lepas Pantai '
        'BalikPapan'
        'Medan'
        'Makassar'
        'Karimunjawa')
    end
    object pnlShipPicture: TPanel
      Left = 897
      Top = 14
      Width = 297
      Height = 173
      TabOrder = 9
      object imgShip: TImage
        Left = 1
        Top = 1
        Width = 295
        Height = 171
        Align = alClient
      end
    end
    object btnSaveScenario: TAdvSmoothButton
      Left = 32
      Top = 576
      Width = 136
      Height = 33
      Cursor = crHandPoint
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -13
      Appearance.Font.Name = 'Tahoma'
      Appearance.Font.Style = [fsBold]
      Status.Caption = '0'
      Status.Appearance.Fill.Color = clRed
      Status.Appearance.Fill.ColorMirror = clNone
      Status.Appearance.Fill.ColorMirrorTo = clNone
      Status.Appearance.Fill.GradientType = gtSolid
      Status.Appearance.Fill.BorderColor = clGray
      Status.Appearance.Fill.Rounding = 0
      Status.Appearance.Fill.ShadowOffset = 0
      Status.Appearance.Fill.Glow = gmNone
      Status.Appearance.Font.Charset = DEFAULT_CHARSET
      Status.Appearance.Font.Color = clWhite
      Status.Appearance.Font.Height = -11
      Status.Appearance.Font.Name = 'Tahoma'
      Status.Appearance.Font.Style = []
      BevelColor = clGray
      Caption = 'Save Scenario'
      Color = clBlack
      ParentFont = False
      TabOrder = 3
      Version = '1.6.9.4'
      OnClick = btnSaveScenarioClick
    end
    object btnClose: TAdvSmoothButton
      Left = 178
      Top = 576
      Width = 75
      Height = 33
      Cursor = crHandPoint
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -13
      Appearance.Font.Name = 'Tahoma'
      Appearance.Font.Style = [fsBold]
      Status.Caption = '0'
      Status.Appearance.Fill.Color = clRed
      Status.Appearance.Fill.ColorMirror = clNone
      Status.Appearance.Fill.ColorMirrorTo = clNone
      Status.Appearance.Fill.GradientType = gtSolid
      Status.Appearance.Fill.BorderColor = clGray
      Status.Appearance.Fill.Rounding = 0
      Status.Appearance.Fill.ShadowOffset = 0
      Status.Appearance.Fill.Glow = gmNone
      Status.Appearance.Font.Charset = DEFAULT_CHARSET
      Status.Appearance.Font.Color = clWhite
      Status.Appearance.Font.Height = -11
      Status.Appearance.Font.Name = 'Tahoma'
      Status.Appearance.Font.Style = []
      BevelColor = clGray
      Caption = 'Close'
      Color = clBlack
      ParentFont = False
      TabOrder = 4
      Version = '1.6.9.4'
      OnClick = btnCloseClick
    end
    object btnPortMore: TAdvSmoothButton
      Left = 329
      Top = 133
      Width = 107
      Height = 28
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -13
      Appearance.Font.Name = 'Tahoma'
      Appearance.Font.Style = [fsBold]
      Status.Caption = '0'
      Status.Appearance.Fill.Color = clRed
      Status.Appearance.Fill.ColorMirror = clNone
      Status.Appearance.Fill.ColorMirrorTo = clNone
      Status.Appearance.Fill.GradientType = gtSolid
      Status.Appearance.Fill.BorderColor = clGray
      Status.Appearance.Fill.Rounding = 0
      Status.Appearance.Fill.ShadowOffset = 0
      Status.Appearance.Fill.Glow = gmNone
      Status.Appearance.Font.Charset = DEFAULT_CHARSET
      Status.Appearance.Font.Color = clWhite
      Status.Appearance.Font.Height = -11
      Status.Appearance.Font.Name = 'Tahoma'
      Status.Appearance.Font.Style = []
      BevelColor = clGray
      Caption = 'More'
      Color = clBlack
      ParentFont = False
      TabOrder = 6
      Version = '1.6.9.4'
      OnClick = btnPortMoreClick
    end
    object btnEditDatabase: TAdvSmoothButton
      Left = 325
      Top = 9
      Width = 114
      Height = 32
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -13
      Appearance.Font.Name = 'Tahoma'
      Appearance.Font.Style = [fsBold]
      Status.Caption = '0'
      Status.Appearance.Fill.Color = clRed
      Status.Appearance.Fill.ColorMirror = clNone
      Status.Appearance.Fill.ColorMirrorTo = clNone
      Status.Appearance.Fill.GradientType = gtSolid
      Status.Appearance.Fill.BorderColor = clGray
      Status.Appearance.Fill.Rounding = 0
      Status.Appearance.Fill.ShadowOffset = 0
      Status.Appearance.Fill.Glow = gmNone
      Status.Appearance.Font.Charset = DEFAULT_CHARSET
      Status.Appearance.Font.Color = clWhite
      Status.Appearance.Font.Height = -11
      Status.Appearance.Font.Name = 'Tahoma'
      Status.Appearance.Font.Style = []
      BevelColor = clGray
      Caption = 'Edit Scenario'
      Color = clBlack
      ParentFont = False
      TabOrder = 7
      Version = '1.6.9.4'
      OnClick = btnEditDatabaseClick
    end
    object btnSetPosition: TAdvSmoothButton
      Left = 415
      Top = 576
      Width = 114
      Height = 33
      Cursor = crHandPoint
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -13
      Appearance.Font.Name = 'Tahoma'
      Appearance.Font.Style = [fsBold]
      Status.Caption = '0'
      Status.Appearance.Fill.Color = clRed
      Status.Appearance.Fill.ColorMirror = clNone
      Status.Appearance.Fill.ColorMirrorTo = clNone
      Status.Appearance.Fill.GradientType = gtSolid
      Status.Appearance.Fill.BorderColor = clGray
      Status.Appearance.Fill.Rounding = 0
      Status.Appearance.Fill.ShadowOffset = 0
      Status.Appearance.Fill.Glow = gmNone
      Status.Appearance.Font.Charset = DEFAULT_CHARSET
      Status.Appearance.Font.Color = clWhite
      Status.Appearance.Font.Height = -11
      Status.Appearance.Font.Name = 'Tahoma'
      Status.Appearance.Font.Style = []
      BevelColor = clGray
      Caption = 'Set Position'
      Color = clBlack
      ParentFont = False
      TabOrder = 8
      Version = '1.6.9.4'
      OnClick = btnSetPositionClick
    end
  end
  object pmConsole: TPopupMenu
    Left = 608
    Top = 416
  end
  object pmConsole2: TPopupMenu
    Left = 640
    Top = 416
  end
end
