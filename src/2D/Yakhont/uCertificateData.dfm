object frmCertificateData: TfrmCertificateData
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 407
  ClientWidth = 456
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
  object pnlCertificateData: TPanel
    Left = 0
    Top = 0
    Width = 457
    Height = 409
    Color = clSilver
    ParentBackground = False
    TabOrder = 0
    object btnCDSNS: TSpeedButton
      Left = 112
      Top = 303
      Width = 97
      Height = 26
      Caption = 'CD SNS'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnCDSNSClick
    end
    object btnCDASM: TSpeedButton
      Left = 256
      Top = 303
      Width = 97
      Height = 26
      Caption = 'CD ASM'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnCDASMClick
    end
    object btnExit: TSpeedButton
      Left = 154
      Top = 347
      Width = 150
      Height = 26
      Caption = 'EXIT - F8'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnExitClick
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 457
      Height = 25
      Caption = 'Certificate Data'
      Color = clTeal
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
    end
    object Panel1: TPanel
      Left = 65
      Top = 279
      Width = 331
      Height = 2
      TabOrder = 1
    end
    object pnlCD_ASM: TPanel
      Left = 9
      Top = 31
      Width = 440
      Height = 240
      TabOrder = 3
      object Label8: TLabel
        Left = 125
        Top = 8
        Width = 201
        Height = 13
        Caption = 'Parametres of angle position of DLC'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label14: TLabel
        Left = 80
        Top = 45
        Width = 35
        Height = 13
        Caption = 'ASM 1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object GroupBox3: TGroupBox
        Left = 137
        Top = 45
        Width = 167
        Height = 29
        TabOrder = 0
        object Label7: TLabel
          Left = 0
          Top = 0
          Width = 10
          Height = 19
          Caption = 'a'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label13: TLabel
          Left = 20
          Top = 5
          Width = 11
          Height = 13
          Caption = 'xk'
        end
        object pnlAx: TPanel
          Left = 67
          Top = 0
          Width = 100
          Height = 28
          Caption = '00 00 00'
          TabOrder = 0
        end
      end
      object GroupBox1: TGroupBox
        Left = 137
        Top = 73
        Width = 167
        Height = 29
        TabOrder = 1
        object Label5: TLabel
          Left = 0
          Top = 0
          Width = 10
          Height = 19
          Caption = 'a'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label12: TLabel
          Left = 20
          Top = 5
          Width = 11
          Height = 13
          Caption = 'yk'
        end
        object pnlAy: TPanel
          Left = 67
          Top = 0
          Width = 100
          Height = 28
          Caption = '00 00 00'
          TabOrder = 0
        end
      end
      object GroupBox2: TGroupBox
        Left = 137
        Top = 101
        Width = 167
        Height = 29
        TabOrder = 2
        object Label6: TLabel
          Left = 0
          Top = 0
          Width = 10
          Height = 19
          Caption = 'q'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object pnlQ: TPanel
          Left = 67
          Top = 0
          Width = 100
          Height = 28
          Caption = '00 00 00'
          TabOrder = 0
        end
      end
      object GroupBox4: TGroupBox
        Left = 137
        Top = 129
        Width = 167
        Height = 29
        TabOrder = 3
        object Label9: TLabel
          Left = 0
          Top = 0
          Width = 7
          Height = 19
          Caption = 'r'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label15: TLabel
          Left = 20
          Top = 5
          Width = 24
          Height = 13
          Caption = 'x , m'
        end
        object pnlRx: TPanel
          Left = 67
          Top = 0
          Width = 100
          Height = 28
          Caption = '00 00 00'
          TabOrder = 0
        end
      end
      object GroupBox5: TGroupBox
        Left = 137
        Top = 157
        Width = 167
        Height = 29
        TabOrder = 4
        object Label10: TLabel
          Left = 0
          Top = 0
          Width = 7
          Height = 19
          Caption = 'r'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label16: TLabel
          Left = 20
          Top = 5
          Width = 24
          Height = 13
          Caption = 'y , m'
        end
        object pnlRy: TPanel
          Left = 67
          Top = 0
          Width = 100
          Height = 28
          Caption = '00 00 00'
          TabOrder = 0
        end
      end
      object GroupBox6: TGroupBox
        Left = 137
        Top = 185
        Width = 167
        Height = 29
        TabOrder = 5
        object Label11: TLabel
          Left = 0
          Top = 0
          Width = 7
          Height = 19
          Caption = 'r'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label17: TLabel
          Left = 20
          Top = 5
          Width = 23
          Height = 13
          Caption = 'z , m'
        end
        object pnlRz: TPanel
          Left = 67
          Top = 0
          Width = 100
          Height = 28
          Caption = '00 00 00'
          TabOrder = 0
        end
      end
    end
    object pnlCD_SNS: TPanel
      Left = 9
      Top = 31
      Width = 440
      Height = 240
      TabOrder = 2
      object Label1: TLabel
        Left = 113
        Top = 16
        Width = 206
        Height = 13
        Caption = 'Parametrers of angle position of SNS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object grpZ: TGroupBox
        Left = 137
        Top = 45
        Width = 167
        Height = 28
        TabOrder = 0
        object Label2: TLabel
          Left = 0
          Top = 0
          Width = 28
          Height = 13
          Caption = 'D Z a'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object pnlDZ: TPanel
          Left = 67
          Top = 0
          Width = 100
          Height = 28
          Caption = '00 00 00'
          TabOrder = 0
        end
      end
      object grpY: TGroupBox
        Left = 137
        Top = 72
        Width = 167
        Height = 28
        TabOrder = 1
        object Label3: TLabel
          Left = 0
          Top = 0
          Width = 28
          Height = 13
          Caption = 'D Y a'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object pnlDy: TPanel
          Left = 67
          Top = 0
          Width = 100
          Height = 28
          Caption = '00 00 00'
          TabOrder = 0
        end
      end
      object grpX: TGroupBox
        Left = 137
        Top = 99
        Width = 167
        Height = 28
        TabOrder = 2
        object Label4: TLabel
          Left = 0
          Top = 0
          Width = 28
          Height = 13
          Caption = 'D X a'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object pnlDx: TPanel
          Left = 67
          Top = 0
          Width = 100
          Height = 28
          Caption = '00 00 00'
          TabOrder = 0
        end
      end
    end
    object pnlNetral: TPanel
      Left = 9
      Top = 31
      Width = 440
      Height = 240
      TabOrder = 4
    end
  end
end
