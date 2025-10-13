object frmTargetDest: TfrmTargetDest
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 600
  ClientWidth = 570
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnShortCut = FormShortCut
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTargetDest_Outer: TPanel
    Left = 0
    Top = 0
    Width = 570
    Height = 600
    Color = clMedGray
    ParentBackground = False
    TabOrder = 0
  end
  object pnlTargetDist_Inner: TPanel
    Left = 8
    Top = 9
    Width = 557
    Height = 584
    Color = clTeal
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 200
      Top = 16
      Width = 135
      Height = 16
      Caption = 'TARGET DESTINATION'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnlValue: TPanel
    Left = 34
    Top = 80
    Width = 505
    Height = 495
    Color = clMedGray
    ParentBackground = False
    TabOrder = 2
    object btnExit: TSpeedButton
      Left = 174
      Top = 448
      Width = 172
      Height = 25
      Caption = 'EXIT - F8'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnExitClick
    end
    object grpValue: TGroupBox
      Left = 8
      Top = 8
      Width = 489
      Height = 193
      TabOrder = 0
      object lblErrorP: TLabel
        Left = 95
        Top = 159
        Width = 3
        Height = 13
        Color = clMedGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object lblErrorQASM: TLabel
        Left = 95
        Top = 159
        Width = 3
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object sgValue: TStringGrid
        Left = 88
        Top = 49
        Width = 310
        Height = 100
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        ColCount = 3
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ScrollBars = ssNone
        TabOrder = 0
        OnDrawCell = sgValueDrawCell
        OnSelectCell = sgValueSelectCell
        OnSetEditText = sgValueSetEditText
      end
    end
    object pnlEnter: TPanel
      Left = 160
      Top = 216
      Width = 201
      Height = 81
      BevelInner = bvLowered
      TabOrder = 1
      object Label2: TLabel
        Left = 72
        Top = 6
        Width = 35
        Height = 16
        Caption = 'Enter'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnP: TSpeedButton
        Left = 14
        Top = 36
        Width = 77
        Height = 27
        Caption = 'P'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnPClick
      end
      object btnQASM: TSpeedButton
        Left = 109
        Top = 35
        Width = 77
        Height = 27
        Caption = 'Q ASM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnQASMClick
      end
    end
    object pnlApproval: TPanel
      Left = 88
      Top = 328
      Width = 337
      Height = 81
      BevelInner = bvLowered
      TabOrder = 2
      object btnMax: TSpeedButton
        Left = 32
        Top = 43
        Width = 81
        Height = 22
        Caption = 'MAX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnMaxClick
      end
      object Label3: TLabel
        Left = 132
        Top = 12
        Width = 59
        Height = 16
        Caption = 'Approval'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnMIP: TSpeedButton
        Left = 132
        Top = 43
        Width = 81
        Height = 22
        Caption = 'MI - P'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnMIPClick
      end
      object btnMIQ: TSpeedButton
        Left = 232
        Top = 43
        Width = 81
        Height = 22
        Caption = 'MI - Q'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnMIQClick
      end
    end
  end
end
