object frmReplayEditoor: TfrmReplayEditoor
  Left = 267
  Top = 186
  Width = 872
  Height = 676
  Caption = 'Replay Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 305
    Top = 0
    Width = 559
    Height = 649
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 0
      Top = 113
      Width = 559
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object Splitter2: TSplitter
      Left = 0
      Top = 116
      Height = 533
    end
    object Panel3: TPanel
      Left = 3
      Top = 116
      Width = 556
      Height = 533
      Align = alClient
      Caption = 'Panel3'
      TabOrder = 0
      object Splitter3: TSplitter
        Left = 1
        Top = 242
        Width = 554
        Height = 3
        Cursor = crVSplit
        Align = alTop
      end
      object sgHistory: TStringGrid
        Left = 1
        Top = 1
        Width = 554
        Height = 241
        Align = alTop
        Ctl3D = False
        DefaultColWidth = 120
        DefaultRowHeight = 16
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
        ParentCtl3D = False
        TabOrder = 0
      end
      object tvData: TTreeView
        Left = 1
        Top = 245
        Width = 554
        Height = 287
        AutoExpand = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        Indent = 19
        ParentFont = False
        PopupMenu = pmTreeView
        TabOrder = 1
        Visible = False
      end
      object sgData: TStringGrid
        Left = 1
        Top = 245
        Width = 554
        Height = 287
        Align = alClient
        ColCount = 6
        Ctl3D = False
        DefaultColWidth = 80
        DefaultRowHeight = 16
        RowCount = 14
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
        ParentCtl3D = False
        TabOrder = 2
      end
    end
    object Panel4: TPanel
      Left = 0
      Top = 0
      Width = 559
      Height = 113
      Align = alTop
      TabOrder = 1
      object memoScenario: TMemo
        Left = 106
        Top = 1
        Width = 288
        Height = 111
        Align = alLeft
        Lines.Strings = (
          'Memo1')
        TabOrder = 0
      end
      object Panel1: TPanel
        Left = 1
        Top = 1
        Width = 105
        Height = 111
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        object btnOpen: TButton
          Left = 8
          Top = 16
          Width = 75
          Height = 25
          Caption = 'OpenFile'
          TabOrder = 0
          OnClick = btnOpenClick
        end
        object btnClose: TButton
          Left = 8
          Top = 48
          Width = 75
          Height = 25
          Caption = 'CloseFile'
          TabOrder = 1
          OnClick = btnCloseClick
        end
      end
    end
  end
  object sgReplayIndex: TStringGrid
    Left = 0
    Top = 0
    Width = 305
    Height = 649
    Align = alLeft
    Ctl3D = False
    DefaultColWidth = 40
    DefaultRowHeight = 16
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    ParentCtl3D = False
    TabOrder = 1
    OnClick = sgReplayIndexClick
    OnDrawCell = sgReplayIndexDrawCell
    ColWidths = (
      40
      84
      56
      52
      57)
  end
  object OpenDlg: TOpenDialog
    InitialDir = '.'
    Left = 184
    Top = 224
  end
  object pmTreeView: TPopupMenu
    Left = 428
    Top = 420
    object ExpandAll1: TMenuItem
      Caption = 'ExpandAll'
      OnClick = ExpandAll1Click
    end
    object CollapseAll1: TMenuItem
      Caption = 'CollapseAll'
      OnClick = CollapseAll1Click
    end
  end
end
