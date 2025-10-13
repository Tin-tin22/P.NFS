object frmCRData: TfrmCRData
  Left = 275
  Top = 475
  BorderStyle = bsNone
  ClientHeight = 260
  ClientWidth = 291
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object pnlCRData: TPanel
    Left = 0
    Top = 0
    Width = 292
    Height = 263
    Color = clAqua
    ParentBackground = False
    TabOrder = 0
    object btnExit: TSpeedButton
      Left = 95
      Top = 217
      Width = 105
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
    object Panel2: TPanel
      Left = 39
      Top = 48
      Width = 217
      Height = 145
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      object btnTI1: TSpeedButton
        Left = 56
        Top = 24
        Width = 105
        Height = 22
        Caption = 'TI 1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnTI2: TSpeedButton
        Left = 56
        Top = 52
        Width = 105
        Height = 22
        Caption = 'TI 2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnTI3: TSpeedButton
        Left = 56
        Top = 80
        Width = 105
        Height = 22
        Caption = 'SNS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 1
      Width = 291
      Height = 41
      BevelOuter = bvNone
      Color = clGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      object Label1: TLabel
        Left = 11
        Top = 10
        Width = 52
        Height = 16
        Caption = 'CR Data'
      end
    end
  end
end
