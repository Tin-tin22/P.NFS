object frmEmergencyRelease: TfrmEmergencyRelease
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 465
  ClientWidth = 575
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  OnShortCut = FormShortCut
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlEmergencyRelease: TPanel
    Left = 0
    Top = 0
    Width = 575
    Height = 465
    Color = clMedGray
    ParentBackground = False
    TabOrder = 0
    object pnlFooter: TPanel
      Left = 7
      Top = 44
      Width = 562
      Height = 415
      Color = clTeal
      ParentBackground = False
      TabOrder = 0
      object pnlMain: TPanel
        Left = 8
        Top = 25
        Width = 545
        Height = 376
        Color = clSilver
        ParentBackground = False
        TabOrder = 0
        object btnExit: TSpeedButton
          Left = 219
          Top = 328
          Width = 150
          Height = 30
          Caption = 'EXIT - F8'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btnExitClick
        end
        object pnlTop: TPanel
          Left = 156
          Top = 10
          Width = 265
          Height = 25
          BevelInner = bvLowered
          BevelOuter = bvNone
          TabOrder = 0
        end
        object pnlLeft: TPanel
          Left = 13
          Top = 47
          Width = 257
          Height = 266
          TabOrder = 1
          object btnApproval: TSpeedButton
            Left = 68
            Top = 194
            Width = 110
            Height = 29
            Caption = 'APPROVAL'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = btnApprovalClick
          end
          object pnlMissile2: TPanel
            Left = 32
            Top = 32
            Width = 57
            Height = 49
            Caption = '2'
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 0
            OnClick = pnlMissile1Click
          end
          object pnlMissile1: TPanel
            Left = 152
            Top = 32
            Width = 57
            Height = 49
            Caption = '1'
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 1
            OnClick = pnlMissile1Click
          end
          object pnlMissile4: TPanel
            Left = 32
            Top = 128
            Width = 57
            Height = 49
            Caption = '4'
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 2
            OnClick = pnlMissile1Click
          end
          object pnlMissile3: TPanel
            Left = 152
            Top = 128
            Width = 57
            Height = 49
            Caption = '3'
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 3
            OnClick = pnlMissile1Click
          end
          object Panel5: TPanel
            Left = 120
            Top = 32
            Width = 2
            Height = 145
            TabOrder = 4
          end
        end
        object pnlRight: TPanel
          Left = 276
          Top = 47
          Width = 257
          Height = 266
          TabOrder = 2
          object Label2: TLabel
            Left = 104
            Top = 16
            Width = 45
            Height = 13
            Caption = 'ASM N 1'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object pnlCancelASM: TPanel
            Left = 12
            Top = 35
            Width = 233
            Height = 24
            BevelInner = bvLowered
            BevelOuter = bvNone
            TabOrder = 0
            object Label3: TLabel
              Left = 16
              Top = 5
              Width = 65
              Height = 13
              Caption = 'Cancel ASM'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object valueCancelASM: TLabel
              Left = 136
              Top = 5
              Width = 61
              Height = 13
              Caption = 'Completed'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
          end
          object pnlSC: TPanel
            Left = 12
            Top = 59
            Width = 233
            Height = 24
            BevelInner = bvLowered
            BevelOuter = bvNone
            Color = clGradientActiveCaption
            ParentBackground = False
            TabOrder = 1
            object Label4: TLabel
              Left = 16
              Top = 5
              Width = 14
              Height = 13
              Caption = 'SC'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
          end
          object pnlBSJoined: TPanel
            Left = 12
            Top = 83
            Width = 233
            Height = 24
            BevelInner = bvLowered
            BevelOuter = bvNone
            Color = clGradientActiveCaption
            ParentBackground = False
            TabOrder = 2
            object Label5: TLabel
              Left = 16
              Top = 5
              Width = 52
              Height = 13
              Caption = 'BS joined'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
          end
          object pnlLiquidInDLC: TPanel
            Left = 12
            Top = 107
            Width = 233
            Height = 24
            BevelInner = bvLowered
            BevelOuter = bvNone
            Color = clGradientActiveCaption
            ParentBackground = False
            TabOrder = 3
            object Label6: TLabel
              Left = 16
              Top = 5
              Width = 70
              Height = 13
              Caption = 'Liquid in DLC'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
          end
          object pnlInitialArticles: TPanel
            Left = 12
            Top = 131
            Width = 233
            Height = 24
            BevelInner = bvLowered
            BevelOuter = bvNone
            Color = clGradientActiveCaption
            ParentBackground = False
            TabOrder = 4
            object Label7: TLabel
              Left = 16
              Top = 5
              Width = 78
              Height = 13
              Caption = 'Initial articles'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
          end
          object pnlArticles2BC: TPanel
            Left = 12
            Top = 155
            Width = 233
            Height = 24
            BevelInner = bvLowered
            BevelOuter = bvNone
            Color = clGradientActiveCaption
            ParentBackground = False
            TabOrder = 5
            object Label8: TLabel
              Left = 16
              Top = 5
              Width = 67
              Height = 13
              Caption = 'Articles 2BC'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
          end
          object pnlMalfunctionOBSC: TPanel
            Left = 12
            Top = 179
            Width = 233
            Height = 24
            BevelInner = bvLowered
            BevelOuter = bvNone
            Color = clGradientActiveCaption
            ParentBackground = False
            TabOrder = 6
            object Label9: TLabel
              Left = 16
              Top = 5
              Width = 98
              Height = 13
              Caption = 'Malfunction OBSC'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
          end
          object pnlInitialBC: TPanel
            Left = 12
            Top = 203
            Width = 233
            Height = 24
            BevelInner = bvLowered
            BevelOuter = bvNone
            Color = clGradientActiveCaption
            ParentBackground = False
            TabOrder = 7
            object Label10: TLabel
              Left = 16
              Top = 5
              Width = 50
              Height = 13
              Caption = 'Initial BC'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
          end
          object Panel1: TPanel
            Left = 12
            Top = 229
            Width = 233
            Height = 29
            BevelInner = bvLowered
            BevelOuter = bvNone
            TabOrder = 8
            object Label11: TLabel
              Left = 81
              Top = 6
              Width = 52
              Height = 13
              Caption = 'Released'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
          end
        end
      end
    end
    object pnlHeader: TPanel
      Left = 7
      Top = 9
      Width = 562
      Height = 29
      TabOrder = 1
      object Label1: TLabel
        Left = 204
        Top = 8
        Width = 133
        Height = 16
        Caption = 'EMERGENCY RELEASE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
end
