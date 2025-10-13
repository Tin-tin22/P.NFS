object frmHeating: TfrmHeating
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 152
  ClientWidth = 450
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlHeating: TPanel
    Left = 0
    Top = 0
    Width = 450
    Height = 150
    Color = clTeal
    ParentBackground = False
    TabOrder = 0
    object pnlheader: TPanel
      Left = 0
      Top = 0
      Width = 450
      Height = 25
      Caption = 'Heating'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object btnExit: TSpeedButtonImage
        Left = 428
        Top = 3
        Width = 20
        Height = 20
        Flat = True
        OnClick = btnExitClick
      end
    end
    object pnlContent: TPanel
      Left = 75
      Top = 44
      Width = 315
      Height = 83
      Caption = 'ASM'#39's is heated up'
      Color = clMoneyGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
    end
  end
  object tmr1: TTimer
    Left = 8
    Top = 32
  end
end
