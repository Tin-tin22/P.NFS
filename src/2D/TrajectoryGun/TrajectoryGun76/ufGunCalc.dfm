object Form1: TForm1
  Left = 0
  Top = 0
  Caption = '`'
  ClientHeight = 693
  ClientWidth = 1016
  Color = 4210752
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clCream
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    1016
    693)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 60
    Height = 590
    Align = alLeft
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 0
    object lblHi: TLabel
      Left = 32
      Top = 288
      Width = 20
      Height = 13
      Caption = 'high'
    end
    object lblLo: TLabel
      Left = 10
      Top = 288
      Width = 16
      Height = 13
      Caption = 'low'
    end
    object lblMarkY: TLabel
      Left = 10
      Top = 4
      Width = 33
      Height = 13
      Caption = 'marker'
    end
    object scBarElevLOW: TScrollBar
      Left = 9
      Top = 317
      Width = 17
      Height = 259
      DoubleBuffered = True
      Kind = sbVertical
      Max = 450
      PageSize = 0
      ParentDoubleBuffered = False
      Position = 360
      TabOrder = 0
      OnChange = scBarElevLOWChange
    end
    object scBarHIGH: TScrollBar
      Left = 32
      Top = 317
      Width = 17
      Height = 259
      DoubleBuffered = True
      Kind = sbVertical
      Max = 800
      Min = 450
      PageSize = 0
      ParentDoubleBuffered = False
      Position = 500
      TabOrder = 1
      OnChange = scBarHIGHChange
    end
    object scMarkHeight: TScrollBar
      Left = 21
      Top = 23
      Width = 28
      Height = 259
      DoubleBuffered = True
      Kind = sbVertical
      Max = 200
      PageSize = 0
      ParentDoubleBuffered = False
      Position = 150
      TabOrder = 2
      OnChange = scMarkHeightChange
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 590
    Width = 1016
    Height = 103
    Align = alBottom
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 1
    object Panel1: TPanel
      Left = 480
      Top = 6
      Width = 361
      Height = 91
      ParentColor = True
      TabOrder = 0
      object Label1: TLabel
        Left = 5
        Top = 6
        Width = 44
        Height = 13
        Caption = 'elevation'
      end
      object Label2: TLabel
        Left = 5
        Top = 26
        Width = 47
        Height = 13
        Caption = 'jarak max'
      end
      object Label5: TLabel
        Left = 5
        Top = 45
        Width = 26
        Height = 13
        Caption = 'T O F'
      end
      object Label7: TLabel
        Left = 5
        Top = 64
        Width = 40
        Height = 13
        Caption = 'tertinggi'
      end
      object edElev: TEdit
        Left = 55
        Top = 4
        Width = 90
        Height = 21
        Alignment = taRightJustify
        BevelKind = bkTile
        BorderStyle = bsNone
        Color = 6316128
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 0
        Text = '10'
      end
      object btnRun: TButton
        Left = 295
        Top = 9
        Width = 50
        Height = 25
        Caption = 'Run'
        TabOrder = 1
        OnClick = btnRunClick
      end
      object edMaxRange: TEdit
        Left = 55
        Top = 25
        Width = 90
        Height = 21
        Alignment = taRightJustify
        BevelKind = bkTile
        BorderStyle = bsNone
        Color = 6316128
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 2
        Text = '10'
      end
      object edTOF: TEdit
        Left = 55
        Top = 46
        Width = 90
        Height = 21
        Alignment = taRightJustify
        BevelKind = bkTile
        BorderStyle = bsNone
        Color = 6316128
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 3
        Text = '10'
      end
      object edTertinggi: TEdit
        Left = 55
        Top = 67
        Width = 90
        Height = 21
        Alignment = taRightJustify
        BevelKind = bkTile
        BorderStyle = bsNone
        Color = 6316128
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 4
        Text = '10'
      end
      object rgElev: TRadioGroup
        Left = 151
        Top = 2
        Width = 82
        Height = 59
        Caption = 'elev Setting'
        ItemIndex = 1
        Items.Strings = (
          'Low'
          'High')
        TabOrder = 5
      end
      object Button2: TButton
        Left = 295
        Top = 39
        Width = 50
        Height = 25
        Caption = 'RSET'
        TabOrder = 6
        OnClick = Button2Click
      end
      object btnLockLo: TButton
        Left = 239
        Top = 8
        Width = 50
        Height = 25
        Caption = 'Lock'
        TabOrder = 7
        OnClick = btnLockLoClick
      end
    end
    object Panel2: TPanel
      Left = 5
      Top = 6
      Width = 469
      Height = 91
      ParentColor = True
      TabOrder = 1
      object LBLtiME: TLabel
        Left = 10
        Top = 9
        Width = 20
        Height = 13
        Caption = 'time'
      end
      object lblRange: TLabel
        Left = 10
        Top = 28
        Width = 28
        Height = 13
        Caption = 'range'
      end
      object lblMarkX: TLabel
        Left = 10
        Top = 47
        Width = 33
        Height = 13
        Caption = 'marker'
      end
      object lblMarkTime_low: TLabel
        Left = 10
        Top = 60
        Width = 23
        Height = 13
        Caption = 't low'
      end
      object lblMarkTime_hi: TLabel
        Left = 10
        Top = 75
        Width = 15
        Height = 13
        Caption = 't hi'
      end
      object scBarTime: TScrollBar
        Left = 76
        Top = 9
        Width = 381
        Height = 16
        DoubleBuffered = True
        Max = 960
        PageSize = 0
        ParentDoubleBuffered = False
        TabOrder = 0
        OnChange = scBarTimeChange
      end
      object scBarMax: TScrollBar
        Left = 76
        Top = 31
        Width = 381
        Height = 16
        DoubleBuffered = True
        Max = 1600
        PageSize = 0
        ParentDoubleBuffered = False
        TabOrder = 1
        OnChange = scBarMaxChange
      end
      object scMarkRange: TScrollBar
        Left = 76
        Top = 53
        Width = 381
        Height = 28
        DoubleBuffered = True
        Max = 1600
        PageSize = 0
        ParentDoubleBuffered = False
        TabOrder = 2
        OnChange = scMarkRangeChange
      end
    end
    object Memo1: TMemo
      Left = 856
      Top = 8
      Width = 153
      Height = 81
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Lines.Strings = (
        'Memo1')
      ParentFont = False
      TabOrder = 2
    end
  end
  object Panel6: TPanel
    Left = 856
    Top = 16
    Width = 152
    Height = 185
    Anchors = [akTop, akRight]
    ParentColor = True
    TabOrder = 2
    object Memo2: TMemo
      Left = 1
      Top = 1
      Width = 150
      Height = 183
      Align = alClient
      BorderStyle = bsNone
      Color = 3158064
      Lines.Strings = (
        'Data sampling range:'
        'Low:'
        '  jarak     (914 - 15544.8 m) '
        '               (0.5 - 8.5 DM)'
        '  waktu   (1.1 - 55.8) detik'
        '  elevasi  (0.3 - 35.9) degree'
        'High:'
        '  jarak     (12070 - 15727.6 m) '
        '               (6.6 - 8.6 DM)'
        '  waktu   (76.2 - 87.7) detik'
        '  elevasi  (67.8 - 54) degree'
        '  ')
      TabOrder = 0
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 20
    OnTimer = Timer1Timer
    Left = 576
    Top = 128
  end
end
