object frmSelectionTI: TfrmSelectionTI
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 250
  ClientWidth = 300
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlSelectionTI: TPanel
    Left = 0
    Top = 0
    Width = 300
    Height = 250
    Color = clGreen
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 11
      Top = 11
      Width = 75
      Height = 16
      Caption = 'Selection TI'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Panel2: TPanel
      Left = 11
      Top = 40
      Width = 277
      Height = 200
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      object btnEM: TSpeedButton
        Left = 80
        Top = 133
        Width = 113
        Height = 33
        Caption = 'EM'
        OnClick = btnMIClick
      end
    end
    object Panel1: TPanel
      Left = 11
      Top = 40
      Width = 277
      Height = 200
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      object btnTI1: TSpeedButton
        Left = 80
        Top = 55
        Width = 113
        Height = 33
        Caption = 'TI 1'
        OnClick = btnTI1Click
      end
      object btnTI2: TSpeedButton
        Left = 80
        Top = 94
        Width = 113
        Height = 33
        Caption = 'TI 2'
        OnClick = btnTI2Click
      end
      object btnMI: TSpeedButton
        Left = 80
        Top = 133
        Width = 113
        Height = 33
        Caption = 'MI'
        OnClick = btnMIClick
      end
    end
  end
end
