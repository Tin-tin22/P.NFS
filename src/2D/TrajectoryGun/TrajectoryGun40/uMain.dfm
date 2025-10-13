object frmGun40trj: TfrmGun40trj
  Left = 0
  Top = 0
  Caption = 'Gun '
  ClientHeight = 574
  ClientWidth = 1061
  Color = clGray
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object pnlLeft: TPanel
    Left = 0
    Top = 491
    Width = 1061
    Height = 41
    Align = alBottom
    TabOrder = 0
    object lbl3: TLabel
      Left = 20
      Top = 14
      Width = 31
      Height = 13
      Caption = 'Range'
    end
    object scrlbrRange: TScrollBar
      Left = 88
      Top = 1
      Width = 972
      Height = 39
      Align = alRight
      Max = 12200
      PageSize = 0
      TabOrder = 0
      OnChange = scrlbrRangeChange
    end
  end
  object pnlUp: TPanel
    Left = 0
    Top = 0
    Width = 1061
    Height = 89
    Align = alTop
    Alignment = taRightJustify
    Caption = 'Meriam 40/120 Trajectory           '
    TabOrder = 1
    object lbl1: TLabel
      Left = 158
      Top = 8
      Width = 76
      Height = 13
      Caption = 'Max Range Gun'
    end
    object lbl2: TLabel
      Left = 158
      Top = 32
      Width = 42
      Height = 13
      Caption = 'Elev Gun'
    end
    object lbl5: TLabel
      Left = 158
      Top = 57
      Width = 66
      Height = 13
      Caption = 'Time Of Flight'
    end
    object lbl6: TLabel
      Left = 232
      Top = 16
      Width = 3
      Height = 13
    end
    object lbl7: TLabel
      Left = 385
      Top = 8
      Width = 40
      Height = 13
      Caption = 'Range X'
    end
    object lbl8: TLabel
      Left = 385
      Top = 34
      Width = 40
      Height = 13
      Caption = 'Range Z'
    end
    object edtElev: TEdit
      Left = 259
      Top = 29
      Width = 107
      Height = 21
      Enabled = False
      TabOrder = 0
      Text = '0'
    end
    object edtRange: TEdit
      Left = 259
      Top = 5
      Width = 107
      Height = 21
      Enabled = False
      TabOrder = 1
      Text = '0'
    end
    object edtTOF: TEdit
      Left = 259
      Top = 54
      Width = 107
      Height = 21
      Enabled = False
      TabOrder = 2
      Text = '0'
    end
    object edtRangeX: TEdit
      Left = 443
      Top = 5
      Width = 107
      Height = 21
      Enabled = False
      TabOrder = 3
      Text = '0'
    end
    object edtRangeZ: TEdit
      Left = 443
      Top = 29
      Width = 107
      Height = 21
      Enabled = False
      TabOrder = 4
      Text = '0'
    end
    object btnRun: TButton
      Left = 570
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Run'
      TabOrder = 5
      OnClick = btnRunClick
    end
    object rgMeriam: TRadioGroup
      Left = 20
      Top = 7
      Width = 113
      Height = 66
      Caption = 'Meriam'
      ItemIndex = 0
      Items.Strings = (
        'Meriam 40'
        'Meriam 120')
      TabOrder = 6
      OnClick = rgMeriamClick
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 532
    Width = 1061
    Height = 42
    Align = alBottom
    TabOrder = 2
    object lbl4: TLabel
      Left = 13
      Top = 14
      Width = 51
      Height = 13
      Caption = 'Time Flight'
    end
    object scrlbrTOF: TScrollBar
      Left = 88
      Top = 1
      Width = 972
      Height = 40
      Align = alRight
      Max = 1000
      PageSize = 0
      TabOrder = 0
      OnChange = scrlbrTOFChange
    end
  end
  object pnlLeft2: TPanel
    Left = 0
    Top = 89
    Width = 49
    Height = 402
    Align = alLeft
    TabOrder = 3
    object scrlbrElev: TScrollBar
      Left = 1
      Top = 1
      Width = 47
      Height = 400
      Align = alClient
      Kind = sbVertical
      Max = 370
      PageSize = 0
      Position = 370
      TabOrder = 0
      OnChange = scrlbrElevChange
    end
  end
  object pnlAir: TPanel
    Left = 917
    Top = 89
    Width = 144
    Height = 402
    Align = alRight
    TabOrder = 4
    object lbl9: TLabel
      Left = 56
      Top = 8
      Width = 48
      Height = 13
      Caption = 'Helicopter'
    end
    object lbl10: TLabel
      Left = 13
      Top = 35
      Width = 13
      Height = 13
      Caption = 'Alt'
    end
    object lbl11: TLabel
      Left = 13
      Top = 64
      Width = 31
      Height = 13
      Caption = 'Range'
    end
    object lbl12: TLabel
      Left = 42
      Top = 158
      Width = 13
      Height = 13
      Caption = 'Alt'
    end
    object lbl13: TLabel
      Left = 85
      Top = 158
      Width = 31
      Height = 13
      Caption = 'Range'
    end
    object edtHeliAlt: TEdit
      Left = 58
      Top = 32
      Width = 72
      Height = 21
      Enabled = False
      TabOrder = 0
      Text = '0'
    end
    object edtHeliRange: TEdit
      Left = 58
      Top = 61
      Width = 72
      Height = 21
      Enabled = False
      TabOrder = 1
      Text = '0'
    end
    object scrlbrHeliAlt: TScrollBar
      Left = 25
      Top = 177
      Width = 47
      Height = 219
      Kind = sbVertical
      Max = 5000
      PageSize = 0
      Position = 5000
      TabOrder = 2
      OnChange = scrlbrHeliAltChange
    end
    object scrlbrHeliRange: TScrollBar
      Left = 78
      Top = 177
      Width = 47
      Height = 219
      Kind = sbVertical
      Max = 10000
      PageSize = 0
      Position = 10000
      TabOrder = 3
      OnChange = scrlbrHeliRangeChange
    end
    object btnHeliLock: TButton
      Left = 58
      Top = 88
      Width = 72
      Height = 25
      Caption = 'Heli Lock'
      TabOrder = 4
      OnClick = btnHeliLockClick
    end
    object btnHeliLock2: TButton
      Left = 58
      Top = 114
      Width = 72
      Height = 25
      Caption = 'Heli Lock 2'
      TabOrder = 5
      OnClick = btnHeliLock2Click
    end
  end
end
