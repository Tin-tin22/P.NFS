object CMControl: TCMControl
  Left = 880
  Top = 265
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = '3D :: Controller'
  ClientHeight = 185
  ClientWidth = 355
  Color = clBtnFace
  TransparentColor = True
  TransparentColorValue = clGray
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 355
    Height = 185
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 1
    Color = clBlack
    ParentBackground = False
    TabOrder = 0
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 353
      Height = 37
      Align = alTop
      BevelOuter = bvNone
      Color = clGray
      ParentBackground = False
      TabOrder = 0
      OnMouseDown = MoveForm
      object pnlTitle: TAdvSmoothPanel
        Left = 0
        Top = 0
        Width = 353
        Height = 37
        Cursor = crDefault
        Caption.Text = '3D ::: CONTROLLER'
        Caption.Location = plCenterLeft
        Caption.HTMLFont.Charset = DEFAULT_CHARSET
        Caption.HTMLFont.Color = clWindowText
        Caption.HTMLFont.Height = -11
        Caption.HTMLFont.Name = 'Tahoma'
        Caption.HTMLFont.Style = []
        Caption.Font.Charset = DEFAULT_CHARSET
        Caption.Font.Color = clWindowText
        Caption.Font.Height = -13
        Caption.Font.Name = 'Arial'
        Caption.Font.Style = [fsBold]
        Caption.ColorStart = clWhite
        Caption.ColorEnd = clWhite
        Caption.Line = False
        Fill.Color = clBlack
        Fill.ColorTo = clBlack
        Fill.ColorMirror = clBlack
        Fill.ColorMirrorTo = clBlack
        Fill.GradientMirrorType = gtVertical
        Fill.Opacity = 101
        Fill.OpacityTo = 243
        Fill.OpacityMirror = 243
        Fill.OpacityMirrorTo = 203
        Fill.BorderColor = clNone
        Fill.BorderWidth = 0
        Fill.Rounding = 3
        Fill.ShadowColor = clNone
        Fill.ShadowOffset = 0
        Fill.Glow = gmNone
        Version = '1.0.9.6'
        Align = alClient
        OnMouseDown = MoveForm
        TabOrder = 0
      end
    end
    object Panel2: TPanel
      Left = 1
      Top = 38
      Width = 353
      Height = 146
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 5
      Color = clGray
      TabOrder = 1
      OnMouseDown = MoveForm
      object pnlMemo: TPanel
        Left = 5
        Top = 5
        Width = 343
        Height = 136
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pnlMemo'
        Color = clGray
        ParentBackground = False
        TabOrder = 0
        object Memo1: TMemo
          Left = 0
          Top = 0
          Width = 343
          Height = 136
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Color = clGray
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
        end
      end
    end
  end
  object Timer2: TTimer
    OnTimer = Timer2Timer
    Left = 384
    Top = 8
  end
  object PopupMenu1: TPopupMenu
    Left = 320
    Top = 32
    object CloseControlClient1: TMenuItem
      Caption = 'Close Client Control '
      OnClick = CloseControlClient1Click
    end
    object StopControlClient1: TMenuItem
      Caption = 'Stop Client Control'
      OnClick = StopControlClient1Click
    end
    object StartControlClient1: TMenuItem
      Caption = 'Start Client Control'
      OnClick = StartControlClient1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object ShowScroll1: TMenuItem
      Caption = 'Show/Hide Scroll'
      OnClick = ShowScroll1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Minimize1: TMenuItem
      Caption = 'Minimize Controller'
      OnClick = Minimize1Click
    end
    object Close1: TMenuItem
      Caption = 'Close Controller'
      OnClick = Close1Click
    end
  end
end
