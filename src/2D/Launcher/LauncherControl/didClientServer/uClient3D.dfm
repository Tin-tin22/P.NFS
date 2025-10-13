object frmMain: TfrmMain
  Left = 934
  Top = 166
  Hint = 'Client 3D'
  BorderIcons = []
  BorderStyle = bsNone
  Caption = '3D :: Launcher'
  ClientHeight = 671
  ClientWidth = 514
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 17
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 514
    Height = 671
    Align = alClient
    BorderWidth = 5
    Color = clGray
    TabOrder = 0
    OnMouseDown = MoveForm
    object Panel1: TPanel
      Left = 6
      Top = 6
      Width = 502
      Height = 630
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 5
      Color = clGray
      TabOrder = 0
      object Memo1: TMemo
        Left = 5
        Top = 58
        Width = 492
        Height = 441
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = clBlack
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clSilver
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object Panel2: TPanel
        Left = 5
        Top = 5
        Width = 492
        Height = 53
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        OnDblClick = Panel2DblClick
        OnMouseDown = MoveForm
        object spb2DServer: TPanel
          Left = 1
          Top = 0
          Width = 196
          Height = 43
          Cursor = crHandPoint
          BevelOuter = bvNone
          BorderStyle = bsSingle
          Caption = '2D SERVER :: OFFLINE'
          Ctl3D = False
          ParentColor = True
          ParentCtl3D = False
          TabOrder = 1
        end
        object btnClose: TPanel
          Left = 522
          Top = 3
          Width = 104
          Height = 43
          Cursor = crHandPoint
          Caption = 'CLOSE'
          TabOrder = 0
          Visible = False
          OnClick = btnCloseClick
        end
        object cbDebug: TCheckBox
          Left = 418
          Top = 10
          Width = 54
          Height = 23
          Alignment = taLeftJustify
          Caption = 'test'
          TabOrder = 2
          Visible = False
          OnClick = cbDebugClick
        end
        object spbDBServer: TPanel
          Left = 200
          Top = 0
          Width = 196
          Height = 43
          Cursor = crHandPoint
          BevelOuter = bvNone
          BorderStyle = bsSingle
          Caption = 'DB SERVER :: OFFLINE'
          Ctl3D = False
          ParentColor = True
          ParentCtl3D = False
          TabOrder = 3
        end
      end
      object Memo2: TMemo
        Left = 5
        Top = 499
        Width = 492
        Height = 126
        Align = alBottom
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = clBlack
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clSilver
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        Visible = False
      end
    end
    object pnlStatus: TPanel
      Left = 6
      Top = 636
      Width = 502
      Height = 29
      Align = alBottom
      BevelOuter = bvNone
      Color = clGray
      TabOrder = 1
      OnMouseDown = MoveForm
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 88
    Top = 104
  end
  object PopupMenu1: TPopupMenu
    Left = 128
    Top = 104
    object Close1: TMenuItem
      Caption = 'Close'
      OnClick = Close1Click
    end
  end
end
