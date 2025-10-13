object frmLock: TfrmLock
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 400
  ClientWidth = 500
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShortCut = FormShortCut
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlLock: TPanel
    Left = 0
    Top = 0
    Width = 500
    Height = 400
    Color = clTeal
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 223
      Top = 13
      Width = 32
      Height = 16
      Caption = 'LOCK'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pnlValue: TPanel
      Left = 10
      Top = 49
      Width = 480
      Height = 340
      Color = clSilver
      ParentBackground = False
      TabOrder = 0
      object btnExit: TSpeedButton
        Left = 157
        Top = 256
        Width = 176
        Height = 33
        Caption = 'EXIT - F8'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnExitClick
      end
      object grpVerticalDev: TGroupBox
        Left = 11
        Top = 40
        Width = 115
        Height = 49
        TabOrder = 0
        object pnlVerticalDev: TPanel
          Left = 7
          Top = 7
          Width = 102
          Height = 36
          TabOrder = 0
          object Label2: TLabel
            Left = 42
            Top = 5
            Width = 46
            Height = 13
            Caption = 'Vertical '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label3: TLabel
            Left = 37
            Top = 19
            Width = 54
            Height = 13
            Caption = 'Deviation'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object pnlVDColor: TPanel
          Left = 16
          Top = 16
          Width = 19
          Height = 17
          BevelInner = bvLowered
          BevelOuter = bvNone
          TabOrder = 1
        end
      end
      object grpTransvAcce: TGroupBox
        Left = 126
        Top = 40
        Width = 115
        Height = 49
        TabOrder = 1
        object pnlTransvAcce: TPanel
          Left = 7
          Top = 7
          Width = 102
          Height = 36
          TabOrder = 0
          object Label4: TLabel
            Left = 32
            Top = 5
            Width = 64
            Height = 13
            Caption = 'Transverse'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label5: TLabel
            Left = 28
            Top = 19
            Width = 71
            Height = 13
            Caption = 'Acceleration'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object pnlTAColor: TPanel
          Left = 16
          Top = 16
          Width = 19
          Height = 17
          BevelInner = bvLowered
          BevelOuter = bvNone
          TabOrder = 1
        end
      end
      object grpVelocityOfShip: TGroupBox
        Left = 241
        Top = 40
        Width = 115
        Height = 49
        TabOrder = 2
        object pnlVelocityOfShip: TPanel
          Left = 7
          Top = 7
          Width = 102
          Height = 36
          TabOrder = 0
          object Label6: TLabel
            Left = 45
            Top = 5
            Width = 45
            Height = 13
            Caption = 'Velocity'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label7: TLabel
            Left = 47
            Top = 19
            Width = 38
            Height = 13
            Caption = 'of Ship'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object pnlVoSColor: TPanel
          Left = 16
          Top = 16
          Width = 19
          Height = 17
          BevelInner = bvLowered
          BevelOuter = bvNone
          TabOrder = 1
        end
      end
      object grpRulesOfControl: TGroupBox
        Left = 356
        Top = 40
        Width = 115
        Height = 49
        TabOrder = 3
        object pnlRulesOfControl: TPanel
          Left = 7
          Top = 7
          Width = 102
          Height = 36
          TabOrder = 0
          object Label8: TLabel
            Left = 47
            Top = 5
            Width = 31
            Height = 13
            Caption = 'Rules'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label9: TLabel
            Left = 39
            Top = 19
            Width = 55
            Height = 13
            Caption = 'of Control'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object pnlRoCColor: TPanel
          Left = 16
          Top = 16
          Width = 19
          Height = 17
          BevelInner = bvLowered
          BevelOuter = bvNone
          TabOrder = 1
        end
      end
      object Panel1: TPanel
        Left = 11
        Top = 232
        Width = 460
        Height = 3
        TabOrder = 4
      end
      object Panel2: TPanel
        Left = 157
        Top = 190
        Width = 176
        Height = 36
        TabOrder = 5
        object Label11: TLabel
          Left = 79
          Top = 11
          Width = 26
          Height = 13
          Caption = 'FULL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Panel3: TPanel
          Left = 15
          Top = 11
          Width = 19
          Height = 17
          BevelInner = bvLowered
          BevelOuter = bvNone
          TabOrder = 0
        end
      end
    end
  end
end
