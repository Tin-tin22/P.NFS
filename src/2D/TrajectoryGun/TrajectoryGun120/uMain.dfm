object frmMain: TfrmMain
  Left = 156
  Top = 206
  Caption = 'Gun Trajectory'
  ClientHeight = 647
  ClientWidth = 1289
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ImgGun: TImage
    Left = 57
    Top = 73
    Width = 1232
    Height = 528
    Align = alClient
  end
  object pnlUp: TPanel
    Left = 0
    Top = 0
    Width = 1289
    Height = 73
    Align = alTop
    Caption = 'Meriam 120'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object lbl1: TLabel
      Left = 16
      Top = 8
      Width = 99
      Height = 22
      Caption = 'Elevasi Gun'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 136
      Top = 8
      Width = 121
      Height = 22
      Caption = 'Time Of Flight'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl3: TLabel
      Left = 920
      Top = 8
      Width = 99
      Height = 22
      Caption = 'Elevasi Gun'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl4: TLabel
      Left = 800
      Top = 8
      Width = 93
      Height = 22
      Caption = 'Range Gun'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 1040
      Top = 8
      Width = 93
      Height = 22
      Caption = 'Range Gun'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 1160
      Top = 8
      Width = 99
      Height = 22
      Caption = 'Elevasi Gun'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtElevGun: TEdit
      Left = 16
      Top = 35
      Width = 99
      Height = 30
      TabOrder = 0
      Text = '0'
    end
    object edtTOF: TEdit
      Left = 137
      Top = 34
      Width = 119
      Height = 30
      TabOrder = 1
      Text = '0'
    end
    object edtRange: TEdit
      Left = 800
      Top = 33
      Width = 100
      Height = 30
      TabOrder = 2
      OnKeyPress = edtRangeKeyPress
    end
    object edtElevCorrect: TEdit
      Left = 921
      Top = 33
      Width = 98
      Height = 30
      TabOrder = 3
    end
    object edtRange2: TEdit
      Left = 1040
      Top = 33
      Width = 100
      Height = 30
      TabOrder = 4
      OnKeyPress = edtRange2KeyPress
    end
    object edtElevCorrect2: TEdit
      Left = 1161
      Top = 33
      Width = 98
      Height = 30
      TabOrder = 5
    end
  end
  object pnlLeft: TPanel
    Left = 0
    Top = 73
    Width = 57
    Height = 528
    Align = alLeft
    TabOrder = 1
    object scrlbrElev: TScrollBar
      Left = 1
      Top = 1
      Width = 55
      Height = 526
      Align = alClient
      Kind = sbVertical
      Max = 400
      PageSize = 0
      Position = 400
      TabOrder = 0
      OnChange = scrlbrElevChange
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 601
    Width = 1289
    Height = 46
    Align = alBottom
    TabOrder = 2
    object scrlbrElevTOF: TScrollBar
      Left = 1
      Top = 1
      Width = 1287
      Height = 44
      Align = alClient
      Max = 2000
      PageSize = 0
      TabOrder = 0
      OnChange = scrlbrElevTOFChange
      ExplicitTop = 5
    end
  end
end
