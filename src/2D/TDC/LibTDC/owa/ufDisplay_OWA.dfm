inherited frmDisplay_Owa: TfrmDisplay_Owa
  Left = 1421
  Top = 604
  Caption = 'frmDisplay_Owa'
  ClientHeight = 300
  ClientWidth = 610
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Left = 1
    Top = 2
    Width = 609
    Height = 297
    Color = 4276545
    Font.Charset = ANSI_CHARSET
    Font.Color = 52479
    Font.Pitch = fpFixed
    inherited AnduTDC15: TEdit
      Top = 258
      Width = 600
      MaxLength = 40
    end
    inherited AnduTDC13: TEdit
      Top = 224
      Width = 600
      MaxLength = 40
    end
    inherited AnduTDC14: TEdit
      Top = 241
      Width = 600
      MaxLength = 40
    end
    inherited AnduTDC09: TEdit
      Top = 156
      Width = 600
      MaxLength = 40
    end
    inherited AnduTDC10: TEdit
      Top = 173
      Width = 600
      MaxLength = 40
    end
    inherited AnduTDC11: TEdit
      Top = 190
      Width = 600
      MaxLength = 40
    end
    inherited AnduTDC12: TEdit
      Top = 207
      Width = 600
      MaxLength = 40
    end
    inherited AnduTDC02: TEdit
      Top = 37
      Width = 600
      MaxLength = 40
    end
    inherited AnduTDC03: TEdit
      Top = 54
      Width = 600
      MaxLength = 40
    end
    inherited AnduTDC04: TEdit
      Top = 71
      Width = 600
      MaxLength = 40
    end
    inherited AnduTDC05: TEdit
      Top = 88
      Width = 600
      MaxLength = 40
    end
    inherited AnduTDC06: TEdit
      Top = 105
      Width = 600
      MaxLength = 40
    end
    inherited AnduTDC07: TEdit
      Top = 122
      Width = 600
      MaxLength = 40
    end
    inherited AnduTDC08: TEdit
      Top = 139
      Width = 600
      MaxLength = 40
    end
    inherited AnduTDC16: TEdit
      Top = 275
      Width = 600
      MaxLength = 40
    end
    inherited AnduTDC01: TEdit
      Top = 20
      Width = 600
      MaxLength = 40
    end
    object edPageHeader: TEdit
      Left = 4
      Top = 3
      Width = 600
      Height = 16
      TabStop = False
      BorderStyle = bsNone
      CharCase = ecUpperCase
      Color = 4210752
      MaxLength = 64
      ReadOnly = True
      TabOrder = 16
    end
  end
  object Edit1: TEdit [1]
    Left = 0
    Top = 317
    Width = 609
    Height = 16
    BorderStyle = bsNone
    CharCase = ecUpperCase
    Color = 4210752
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'ANDU Console'
    Font.Style = []
    HideSelection = False
    MaxLength = 64
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
    Text = '12345678901234567890123456789012345678'
    OnKeyPress = AnduTDC16KeyPress
  end
end
