object frmLogger: TfrmLogger
  Left = 187
  Top = 118
  Width = 798
  Height = 607
  Caption = 'scanner'
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
  object pnlReplay: TPanel
    Left = 129
    Top = 0
    Width = 653
    Height = 569
    Align = alClient
    BorderWidth = 1
    TabOrder = 0
    object ProgressBar1: TProgressBar
      Left = 2
      Top = 2
      Width = 649
      Height = 17
      Align = alTop
      TabOrder = 0
    end
    object ScrollBar1: TScrollBar
      Left = 2
      Top = 19
      Width = 649
      Height = 17
      Align = alTop
      PageSize = 0
      TabOrder = 1
      OnChange = ScrollBar1Change
    end
    object Panel3: TPanel
      Left = 2
      Top = 36
      Width = 151
      Height = 531
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 2
      object Memo2: TMemo
        Left = 0
        Top = 257
        Width = 151
        Height = 274
        Align = alClient
        Lines.Strings = (
          'Memo2')
        TabOrder = 0
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 151
        Height = 257
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object btnOpenFile: TButton
          Left = 8
          Top = 16
          Width = 121
          Height = 25
          Caption = 'OpenFile'
          TabOrder = 0
          OnClick = btnOpenFileClick
        end
        object btnPause: TButton
          Left = 8
          Top = 104
          Width = 75
          Height = 25
          Caption = 'Pause'
          TabOrder = 1
          OnClick = btnPauseClick
        end
        object btnResume: TButton
          Left = 8
          Top = 128
          Width = 75
          Height = 25
          Caption = 'Resume'
          TabOrder = 2
          OnClick = btnResumeClick
        end
        object btnStartReplay: TButton
          Left = 8
          Top = 48
          Width = 121
          Height = 25
          Caption = 'StartReplay'
          TabOrder = 3
          OnClick = btnStartReplayClick
        end
        object btnStopReplay: TButton
          Left = 8
          Top = 72
          Width = 121
          Height = 25
          Caption = 'StopReplay'
          TabOrder = 4
          OnClick = btnStopReplayClick
        end
        object rgReplayGameSpeed: TRadioGroup
          Left = 13
          Top = 160
          Width = 89
          Height = 89
          Caption = 'Speed'
          ItemIndex = 0
          Items.Strings = (
            'satu'
            'dua'
            'empat'
            'delapan')
          TabOrder = 5
          OnClick = rgReplayGameSpeedClick
        end
      end
    end
    object Panel4: TPanel
      Left = 153
      Top = 36
      Width = 498
      Height = 531
      Align = alClient
      BevelOuter = bvNone
      Caption = 'Panel4'
      TabOrder = 3
      object Memo1: TMemo
        Left = 0
        Top = 41
        Width = 120
        Height = 490
        Align = alLeft
        Lines.Strings = (
          'Memo1')
        TabOrder = 0
      end
      object sGrid: TStringGrid
        Left = 120
        Top = 41
        Width = 378
        Height = 490
        Align = alClient
        ColCount = 6
        Ctl3D = False
        DefaultRowHeight = 16
        FixedCols = 0
        RowCount = 48
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        ParentCtl3D = False
        TabOrder = 1
        OnDrawCell = sGridDrawCell
        ColWidths = (
          41
          71
          68
          69
          42
          64)
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 498
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object lblFrameInfo: TLabel
          Left = 0
          Top = 8
          Width = 3
          Height = 13
        end
        object Label2: TLabel
          Left = 8
          Top = 8
          Width = 112
          Height = 20
          Caption = 'Replay Tester'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
  end
  object pnlLog: TPanel
    Left = 0
    Top = 0
    Width = 129
    Height = 569
    Align = alLeft
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = 'pnlLog'
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 32
      Height = 13
      Caption = 'Label1'
    end
    object Label3: TLabel
      Left = 8
      Top = 32
      Width = 62
      Height = 29
      Caption = 'L O G'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblTrackBar: TLabel
      Left = 40
      Top = 336
      Width = 12
      Height = 13
      Caption = '40'
    end
    object trbDelay: TTrackBar
      Left = 8
      Top = 72
      Width = 25
      Height = 289
      Enabled = False
      LineSize = 10
      Max = 40
      Min = 1
      Orientation = trVertical
      PageSize = 5
      Frequency = 5
      Position = 40
      TabOrder = 0
      ThumbLength = 16
      TickMarks = tmTopLeft
      OnChange = trbDelayChange
    end
    object btnSave: TButton
      Left = 48
      Top = 272
      Width = 75
      Height = 25
      Caption = 'btnSave'
      TabOrder = 1
      OnClick = btnSaveClick
    end
    object btnStart: TButton
      Left = 48
      Top = 208
      Width = 75
      Height = 25
      Caption = 'btnStart'
      TabOrder = 2
      OnClick = btnStartClick
    end
    object btnStop: TButton
      Left = 48
      Top = 240
      Width = 75
      Height = 25
      Caption = 'btnStop'
      TabOrder = 3
      OnClick = btnStopClick
    end
    object rgLogGameSpeed: TRadioGroup
      Left = 48
      Top = 72
      Width = 73
      Height = 97
      Caption = 'Speed'
      ItemIndex = 0
      Items.Strings = (
        'satu'
        'dua'
        'empat'
        'delapan')
      TabOrder = 4
      OnClick = rgLogGameSpeedClick
    end
  end
  object OpenDlg: TOpenDialog
    InitialDir = '.'
    Left = 392
    Top = 112
  end
  object SaveDialog1: TSaveDialog
    Left = 427
    Top = 108
  end
end
