object frmCirculationASM: TfrmCirculationASM
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 300
  ClientWidth = 400
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
  object pnlCirculationASM: TPanel
    Left = 0
    Top = 0
    Width = 400
    Height = 300
    Color = clTeal
    ParentBackground = False
    TabOrder = 0
    object lblASM: TLabel
      Left = 7
      Top = 12
      Width = 111
      Height = 16
      Caption = 'Cancellation ASM'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pnlMain: TPanel
      Left = 7
      Top = 50
      Width = 386
      Height = 241
      Color = clSilver
      ParentBackground = False
      TabOrder = 0
      object btnExit: TSpeedButton
        Left = 139
        Top = 208
        Width = 116
        Height = 22
        Caption = 'EXIT - F8'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnExitClick
      end
      object grpMissile2: TGroupBox
        Left = 57
        Top = 16
        Width = 89
        Height = 81
        TabOrder = 0
        OnClick = pnlMissile2Click
        object pnlMissile2: TPanel
          Left = 0
          Top = 16
          Width = 73
          Height = 65
          TabOrder = 0
          OnClick = pnlMissile2Click
          object lbl2: TLabel
            Left = 40
            Top = 32
            Width = 8
            Height = 16
            Caption = '2'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object colorMissile2: TPanel
            Left = 7
            Top = 32
            Width = 17
            Height = 17
            Color = clCream
            ParentBackground = False
            TabOrder = 0
            OnClick = pnlMissile2Click
          end
        end
      end
      object grpMissile3: TGroupBox
        Left = 246
        Top = 103
        Width = 89
        Height = 81
        TabOrder = 1
        OnClick = pnlMissile3Click
        object pnlMissile3: TPanel
          Left = 0
          Top = 16
          Width = 73
          Height = 65
          TabOrder = 0
          OnClick = pnlMissile3Click
          object lbl3: TLabel
            Left = 40
            Top = 32
            Width = 8
            Height = 16
            Caption = '3'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object colorMissile3: TPanel
            Left = 7
            Top = 32
            Width = 17
            Height = 17
            Color = clCream
            ParentBackground = False
            TabOrder = 0
            OnClick = pnlMissile3Click
          end
        end
      end
      object grpMissile4: TGroupBox
        Left = 57
        Top = 103
        Width = 89
        Height = 81
        TabOrder = 2
        OnClick = pnlMissile3Click
        object pnlMissile4: TPanel
          Left = 0
          Top = 16
          Width = 73
          Height = 65
          TabOrder = 0
          OnClick = pnlMissile4Click
          object lbl4: TLabel
            Left = 40
            Top = 32
            Width = 8
            Height = 16
            Caption = '4'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object colorMissile4: TPanel
            Left = 7
            Top = 32
            Width = 17
            Height = 17
            Color = clCream
            ParentBackground = False
            TabOrder = 0
            OnClick = pnlMissile3Click
          end
        end
      end
      object grpMissile1: TGroupBox
        Left = 246
        Top = 16
        Width = 89
        Height = 81
        TabOrder = 3
        OnClick = pnlMissile1Click
        object pnlMissile1: TPanel
          Left = 0
          Top = 16
          Width = 73
          Height = 65
          TabOrder = 0
          OnClick = pnlMissile1Click
          object lbl1: TLabel
            Left = 40
            Top = 32
            Width = 8
            Height = 16
            Caption = '1'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object colorMissile1: TPanel
            Left = 7
            Top = 32
            Width = 17
            Height = 17
            Color = clCream
            ParentBackground = False
            TabOrder = 0
            OnClick = pnlMissile1Click
          end
        end
      end
      object Panel1: TPanel
        Left = 196
        Top = 16
        Width = 2
        Height = 168
        TabOrder = 4
      end
    end
  end
end
