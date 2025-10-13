object frmCMServer: TfrmCMServer
  Left = 862
  Top = 306
  Hint = 'Server 2 D & 3D'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Client Management'
  ClientHeight = 382
  ClientWidth = 520
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 363
    Width = 520
    Height = 19
    Panels = <>
  end
  object Panel1: TPanel
    Left = 113
    Top = 0
    Width = 407
    Height = 363
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvNone
    BorderWidth = 5
    TabOrder = 1
    object listClient: TListView
      Left = 6
      Top = 36
      Width = 395
      Height = 234
      Align = alClient
      BevelOuter = bvNone
      BorderStyle = bsNone
      Columns = <
        item
          Caption = 'ID'
          Width = 35
        end
        item
          Caption = 'Name'
          Width = 210
        end
        item
          Alignment = taCenter
          Caption = 'Type'
          Width = 45
        end
        item
          Alignment = taCenter
          Caption = 'IP'
          Width = 80
        end>
      FlatScrollBars = True
      GridLines = True
      ReadOnly = True
      RowSelect = True
      PopupMenu = PopupMenu1
      SortType = stText
      TabOrder = 0
      ViewStyle = vsReport
    end
    object Panel3: TPanel
      Left = 6
      Top = 6
      Width = 395
      Height = 30
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Label1: TLabel
        Left = 6
        Top = 8
        Width = 3
        Height = 13
      end
      object Edit1: TEdit
        Left = 334
        Top = 5
        Width = 54
        Height = 21
        Color = clBtnFace
        TabOrder = 0
        Text = '1'
        OnChange = Edit1Change
      end
    end
    object Memo1: TMemo
      Left = 6
      Top = 270
      Width = 395
      Height = 87
      Align = alBottom
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSilver
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 113
    Height = 363
    Align = alLeft
    BevelOuter = bvNone
    BorderWidth = 5
    TabOrder = 2
    OnMouseDown = Panel2MouseDown
    object btnRun3DServer: TSpeedButton
      Left = 9
      Top = 5
      Width = 100
      Height = 30
      Cursor = crHandPoint
      Caption = 'Run 3D Server'
      OnClick = btnRun3DServerClick
    end
    object btnRunClient: TSpeedButton
      Left = 9
      Top = 36
      Width = 100
      Height = 30
      Cursor = crHandPoint
      Caption = 'Run Client'
      OnClick = btnRunClientClick
    end
    object btStop: TSpeedButton
      Left = 9
      Top = 75
      Width = 100
      Height = 30
      Cursor = crHandPoint
      Caption = 'Stop'
      OnClick = btStopClick
    end
    object btReset: TSpeedButton
      Left = 9
      Top = 105
      Width = 100
      Height = 30
      Cursor = crHandPoint
      Caption = 'Reset'
      OnClick = btResetClick
    end
    object btRefresh: TSpeedButton
      Left = 9
      Top = 144
      Width = 100
      Height = 30
      Cursor = crHandPoint
      Caption = 'Refresh Client'
      OnClick = btRefreshClick
    end
    object Bevel1: TBevel
      Left = 7
      Top = 71
      Width = 104
      Height = 2
    end
    object SpeedButton1: TSpeedButton
      Left = 9
      Top = 328
      Width = 100
      Height = 30
      Cursor = crHandPoint
      Caption = 'Setting'
      Visible = False
      OnClick = SpeedButton1Click
    end
    object Bevel2: TBevel
      Left = 7
      Top = 139
      Width = 104
      Height = 2
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 353
    Top = 136
    object Run1: TMenuItem
      Caption = 'Run'
      OnClick = Run1Click
    end
    object Stop1: TMenuItem
      Caption = 'Stop'
      OnClick = Stop1Click
    end
    object Reset1: TMenuItem
      Caption = 'Reset'
      OnClick = Reset1Click
    end
  end
end
