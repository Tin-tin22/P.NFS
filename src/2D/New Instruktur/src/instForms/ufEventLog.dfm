object frmEventLog: TfrmEventLog
  Left = 182
  Top = 220
  Width = 1447
  Height = 750
  Caption = 'Log Event'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object AdvEventLog: TAdvPageControl
    Left = 0
    Top = 0
    Width = 1439
    Height = 723
    ActivePage = tabRBU
    ActiveFont.Charset = DEFAULT_CHARSET
    ActiveFont.Color = clMenuHighlight
    ActiveFont.Height = -16
    ActiveFont.Name = 'Tahoma'
    ActiveFont.Style = [fsBold]
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    DefaultTabColor = clGray
    DefaultTabColorTo = clHighlightText
    ActiveColor = clNone
    TabBorderColor = clSilver
    TabSheet3D = True
    TabBackGroundColor = clBtnShadow
    TabMargin.RightMargin = 0
    TabOverlap = 0
    TabSplitLine = True
    Version = '1.7.1.0'
    TabOrder = 0
    TabWidth = 170
    object tabTOCOS: TAdvTabSheet
      Caption = 'TOCOS'
      Color = clBtnShadow
      ColorTo = clNone
      TabColor = clGray
      TabColorTo = clHighlightText
      object lvCommandTocos: TAdvListView
        Left = 0
        Top = 0
        Width = 1431
        Height = 689
        Align = alClient
        Columns = <
          item
            AutoSize = True
            Caption = 'Scenario'
          end
          item
            AutoSize = True
            Caption = 'Game'
          end
          item
            AutoSize = True
            Caption = 'Ship'
          end
          item
            AutoSize = True
            Caption = 'Event'
          end
          item
            Caption = 'Time'
            Width = 1074
          end>
        ColumnClick = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        GridLines = True
        MultiSelect = True
        RowSelect = True
        ParentFont = False
        TabOrder = 0
        ViewStyle = vsReport
        ClipboardEnable = True
        ColumnSize.Save = True
        ColumnSize.Stretch = True
        PrintSettings.DateFormat = 'dd/mm/yyyy'
        PrintSettings.Font.Charset = DEFAULT_CHARSET
        PrintSettings.Font.Color = clWindowText
        PrintSettings.Font.Height = -11
        PrintSettings.Font.Name = 'MS Sans Serif'
        PrintSettings.Font.Style = []
        PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
        PrintSettings.HeaderFont.Color = clWindowText
        PrintSettings.HeaderFont.Height = -11
        PrintSettings.HeaderFont.Name = 'MS Sans Serif'
        PrintSettings.HeaderFont.Style = []
        PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
        PrintSettings.FooterFont.Color = clWindowText
        PrintSettings.FooterFont.Height = -11
        PrintSettings.FooterFont.Name = 'MS Sans Serif'
        PrintSettings.FooterFont.Style = []
        PrintSettings.PageNumSep = '/'
        HeaderColor = clGray
        HeaderOwnerDraw = True
        HeaderHeight = 20
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWhite
        HeaderFont.Height = -15
        HeaderFont.Name = 'Tahoma'
        HeaderFont.Style = [fsBold]
        StretchColumn = True
        SubItemEdit = True
        SubItemSelect = True
        ItemHeight = 17
        DetailView.Visible = True
        DetailView.Font.Charset = DEFAULT_CHARSET
        DetailView.Font.Color = clBlue
        DetailView.Font.Height = -11
        DetailView.Font.Name = 'MS Sans Serif'
        DetailView.Font.Style = []
        DetailView.SplitLine = True
        Version = '1.6.5.1'
      end
    end
    object tabC802: TAdvTabSheet
      Caption = 'C802'
      Color = clBtnShadow
      ColorTo = clNone
      TabColor = clGray
      TabColorTo = clHighlightText
      object lvCommandC802: TAdvListView
        Left = 0
        Top = 0
        Width = 1431
        Height = 689
        Align = alClient
        Columns = <
          item
            AutoSize = True
            Caption = 'Scenario'
          end
          item
            AutoSize = True
            Caption = 'Game'
          end
          item
            AutoSize = True
            Caption = 'Ship'
          end
          item
            AutoSize = True
            Caption = 'Event'
          end
          item
            Caption = 'Time'
            Width = 1207
          end>
        ColumnClick = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        GridLines = True
        MultiSelect = True
        RowSelect = True
        ParentFont = False
        TabOrder = 0
        ViewStyle = vsReport
        ClipboardEnable = True
        ColumnSize.Save = True
        ColumnSize.Stretch = True
        PrintSettings.DateFormat = 'dd/mm/yyyy'
        PrintSettings.Font.Charset = DEFAULT_CHARSET
        PrintSettings.Font.Color = clWindowText
        PrintSettings.Font.Height = -11
        PrintSettings.Font.Name = 'MS Sans Serif'
        PrintSettings.Font.Style = []
        PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
        PrintSettings.HeaderFont.Color = clWindowText
        PrintSettings.HeaderFont.Height = -11
        PrintSettings.HeaderFont.Name = 'MS Sans Serif'
        PrintSettings.HeaderFont.Style = []
        PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
        PrintSettings.FooterFont.Color = clWindowText
        PrintSettings.FooterFont.Height = -11
        PrintSettings.FooterFont.Name = 'MS Sans Serif'
        PrintSettings.FooterFont.Style = []
        PrintSettings.PageNumSep = '/'
        HeaderColor = clGray
        HeaderOwnerDraw = True
        HeaderHeight = 20
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWhite
        HeaderFont.Height = -15
        HeaderFont.Name = 'Tahoma'
        HeaderFont.Style = [fsBold]
        StretchColumn = True
        SubItemEdit = True
        SubItemSelect = True
        ItemHeight = 17
        DetailView.Visible = True
        DetailView.Font.Charset = DEFAULT_CHARSET
        DetailView.Font.Color = clBlue
        DetailView.Font.Height = -11
        DetailView.Font.Name = 'MS Sans Serif'
        DetailView.Font.Style = []
        DetailView.SplitLine = True
        Version = '1.6.5.1'
      end
    end
    object tabYakhont: TAdvTabSheet
      Caption = 'YAKHONT'
      Color = clBtnShadow
      ColorTo = clNone
      TabColor = clGray
      TabColorTo = clHighlightText
      object lvCommandYakhont: TAdvListView
        Left = 0
        Top = 0
        Width = 1431
        Height = 689
        Align = alClient
        Columns = <
          item
            AutoSize = True
            Caption = 'Scenario'
          end
          item
            AutoSize = True
            Caption = 'Game'
          end
          item
            AutoSize = True
            Caption = 'Ship'
          end
          item
            AutoSize = True
            Caption = 'Event'
          end
          item
            Caption = 'Time'
            Width = 1207
          end>
        ColumnClick = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        GridLines = True
        MultiSelect = True
        RowSelect = True
        ParentFont = False
        TabOrder = 0
        ViewStyle = vsReport
        ClipboardEnable = True
        ColumnSize.Save = True
        ColumnSize.Stretch = True
        PrintSettings.DateFormat = 'dd/mm/yyyy'
        PrintSettings.Font.Charset = DEFAULT_CHARSET
        PrintSettings.Font.Color = clWindowText
        PrintSettings.Font.Height = -11
        PrintSettings.Font.Name = 'MS Sans Serif'
        PrintSettings.Font.Style = []
        PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
        PrintSettings.HeaderFont.Color = clWindowText
        PrintSettings.HeaderFont.Height = -11
        PrintSettings.HeaderFont.Name = 'MS Sans Serif'
        PrintSettings.HeaderFont.Style = []
        PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
        PrintSettings.FooterFont.Color = clWindowText
        PrintSettings.FooterFont.Height = -11
        PrintSettings.FooterFont.Name = 'MS Sans Serif'
        PrintSettings.FooterFont.Style = []
        PrintSettings.PageNumSep = '/'
        HeaderColor = clGray
        HeaderOwnerDraw = True
        HeaderHeight = 20
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWhite
        HeaderFont.Height = -15
        HeaderFont.Name = 'Tahoma'
        HeaderFont.Style = [fsBold]
        StretchColumn = True
        SubItemEdit = True
        SubItemSelect = True
        ItemHeight = 17
        DetailView.Visible = True
        DetailView.Font.Charset = DEFAULT_CHARSET
        DetailView.Font.Color = clBlue
        DetailView.Font.Height = -11
        DetailView.Font.Name = 'MS Sans Serif'
        DetailView.Font.Style = []
        DetailView.SplitLine = True
        Version = '1.6.5.1'
      end
    end
    object tabRBU: TAdvTabSheet
      Caption = 'RBU'
      Color = clBtnShadow
      ColorTo = clBtnFace
      TabColor = clGray
      TabColorTo = clHighlightText
      object lvCommandRBU: TAdvListView
        Left = 0
        Top = 0
        Width = 1431
        Height = 689
        Align = alClient
        Columns = <
          item
            AutoSize = True
            Caption = 'Scenario'
          end
          item
            AutoSize = True
            Caption = 'Game'
          end
          item
            AutoSize = True
            Caption = 'Ship'
          end
          item
            AutoSize = True
            Caption = 'Event'
          end
          item
            Caption = 'Time'
            Width = 1207
          end>
        ColumnClick = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        GridLines = True
        MultiSelect = True
        RowSelect = True
        ParentFont = False
        TabOrder = 0
        ViewStyle = vsReport
        ClipboardEnable = True
        ColumnSize.Save = True
        ColumnSize.Stretch = True
        PrintSettings.DateFormat = 'dd/mm/yyyy'
        PrintSettings.Font.Charset = DEFAULT_CHARSET
        PrintSettings.Font.Color = clWindowText
        PrintSettings.Font.Height = -11
        PrintSettings.Font.Name = 'MS Sans Serif'
        PrintSettings.Font.Style = []
        PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
        PrintSettings.HeaderFont.Color = clWindowText
        PrintSettings.HeaderFont.Height = -11
        PrintSettings.HeaderFont.Name = 'MS Sans Serif'
        PrintSettings.HeaderFont.Style = []
        PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
        PrintSettings.FooterFont.Color = clWindowText
        PrintSettings.FooterFont.Height = -11
        PrintSettings.FooterFont.Name = 'MS Sans Serif'
        PrintSettings.FooterFont.Style = []
        PrintSettings.PageNumSep = '/'
        HeaderColor = clGray
        HeaderOwnerDraw = True
        HeaderHeight = 20
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWhite
        HeaderFont.Height = -15
        HeaderFont.Name = 'Tahoma'
        HeaderFont.Style = [fsBold]
        StretchColumn = True
        SubItemEdit = True
        SubItemSelect = True
        ItemHeight = 17
        DetailView.Visible = True
        DetailView.Font.Charset = DEFAULT_CHARSET
        DetailView.Font.Color = clBlue
        DetailView.Font.Height = -11
        DetailView.Font.Name = 'MS Sans Serif'
        DetailView.Font.Style = []
        DetailView.SplitLine = True
        Version = '1.6.5.1'
      end
    end
    object tabASROC: TAdvTabSheet
      Caption = 'ASROC'
      Color = clBtnShadow
      ColorTo = clBtnFace
      TabColor = clGray
      TabColorTo = clHighlightText
      object lvCommandAsroc: TAdvListView
        Left = 0
        Top = 0
        Width = 1431
        Height = 689
        Align = alClient
        Columns = <
          item
            AutoSize = True
            Caption = 'Scenario'
          end
          item
            AutoSize = True
            Caption = 'Game'
          end
          item
            AutoSize = True
            Caption = 'Ship'
          end
          item
            AutoSize = True
            Caption = 'Event'
          end
          item
            Caption = 'Time'
            Width = 1207
          end>
        ColumnClick = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        GridLines = True
        MultiSelect = True
        RowSelect = True
        ParentFont = False
        TabOrder = 0
        ViewStyle = vsReport
        ClipboardEnable = True
        ColumnSize.Save = True
        ColumnSize.Stretch = True
        PrintSettings.DateFormat = 'dd/mm/yyyy'
        PrintSettings.Font.Charset = DEFAULT_CHARSET
        PrintSettings.Font.Color = clWindowText
        PrintSettings.Font.Height = -11
        PrintSettings.Font.Name = 'MS Sans Serif'
        PrintSettings.Font.Style = []
        PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
        PrintSettings.HeaderFont.Color = clWindowText
        PrintSettings.HeaderFont.Height = -11
        PrintSettings.HeaderFont.Name = 'MS Sans Serif'
        PrintSettings.HeaderFont.Style = []
        PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
        PrintSettings.FooterFont.Color = clWindowText
        PrintSettings.FooterFont.Height = -11
        PrintSettings.FooterFont.Name = 'MS Sans Serif'
        PrintSettings.FooterFont.Style = []
        PrintSettings.PageNumSep = '/'
        HeaderColor = clGray
        HeaderOwnerDraw = True
        HeaderHeight = 20
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWhite
        HeaderFont.Height = -15
        HeaderFont.Name = 'Tahoma'
        HeaderFont.Style = [fsBold]
        StretchColumn = True
        SubItemEdit = True
        SubItemSelect = True
        ItemHeight = 17
        DetailView.Visible = True
        DetailView.Font.Charset = DEFAULT_CHARSET
        DetailView.Font.Color = clBlue
        DetailView.Font.Height = -11
        DetailView.Font.Name = 'MS Sans Serif'
        DetailView.Font.Style = []
        DetailView.SplitLine = True
        Version = '1.6.5.1'
      end
    end
  end
end
