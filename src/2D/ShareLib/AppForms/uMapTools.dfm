object frmMapTools: TfrmMapTools
  Left = 219
  Top = 256
  Width = 208
  Height = 109
  BorderStyle = bsSizeToolWin
  Caption = 'frmMapTools'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object tlbStdMapMenu: TToolBar
    Left = 0
    Top = 0
    Width = 200
    Height = 33
    ButtonHeight = 21
    Caption = 'tlbStdMapMenu'
    EdgeBorders = [ebTop, ebBottom]
    ShowCaptions = True
    TabOrder = 0
    object tbtnArrow: TToolButton
      Left = 0
      Top = 2
      Caption = ' <- '
      Down = True
      Grouped = True
      ImageIndex = 0
      Style = tbsCheck
      OnClick = tbtnArrowClick
    end
    object tbtnZoomIn: TToolButton
      Left = 23
      Top = 2
      Caption = ' + '
      Grouped = True
      ImageIndex = 1
      Style = tbsCheck
      OnClick = tbtnArrowClick
    end
    object tbtnZoomOut: TToolButton
      Left = 46
      Top = 2
      Caption = ' - '
      Grouped = True
      ImageIndex = 2
      Style = tbsCheck
      OnClick = tbtnArrowClick
    end
    object tbtnPan: TToolButton
      Left = 69
      Top = 2
      Caption = '~'
      Grouped = True
      ImageIndex = 3
      Style = tbsCheck
      OnClick = tbtnArrowClick
    end
    object tbtnCenter: TToolButton
      Left = 92
      Top = 2
      Caption = '*'
      Grouped = True
      ImageIndex = 4
      Style = tbsCheck
      OnClick = tbtnArrowClick
    end
    object ToolButton7: TToolButton
      Left = 115
      Top = 2
      Width = 8
      Caption = 'Too'
      Enabled = False
      ImageIndex = 6
      Style = tbsSeparator
    end
    object tbtnDistance: TToolButton
      Left = 123
      Top = 2
      Caption = 'dist'
      ImageIndex = 6
      OnClick = tbtnDistanceClick
    end
  end
end
