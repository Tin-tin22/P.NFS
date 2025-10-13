object frmWCCPanelTengah_Rencong: TfrmWCCPanelTengah_Rencong
  Left = 192
  Top = 114
  Width = 696
  Height = 480
  Caption = 'WCC PANEL TENGAH'
  Color = clMoneyGreen
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 7
    Top = 5
    Width = 1137
    Height = 505
    Color = clMoneyGreen
    TabOrder = 0
    object Image1: TImage
      Left = 288
      Top = 32
      Width = 473
      Height = 473
      Transparent = True
    end
    object VrBlinkLed3: TVrBlinkLed
      Left = 852
      Top = 16
      Width = 26
      Height = 33
      Palette1.Low = clBlack
      Palette1.High = clRed
      Palette2.Low = clBlack
      Palette2.High = clAqua
      Palette3.Low = clBlack
      Palette3.High = clYellow
      Palette4.Low = clBlack
      Palette4.High = clLime
      Margin = 2
      Spacing = 3
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      BlinkSpeed = 500
    end
    object VrBlinkLed1: TVrBlinkLed
      Left = 892
      Top = 16
      Width = 26
      Height = 33
      Palette1.Low = clBlack
      Palette1.High = clRed
      Palette2.Low = clBlack
      Palette2.High = clAqua
      Palette3.Low = clBlack
      Palette3.High = clYellow
      Palette4.Low = clBlack
      Palette4.High = clLime
      Margin = 2
      Spacing = 3
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      BlinkSpeed = 500
    end
    object GroupBox2: TGroupBox
      Left = 808
      Top = 56
      Width = 145
      Height = 97
      TabOrder = 0
      object Shape2: TShape
        Left = 9
        Top = 15
        Width = 129
        Height = 74
      end
    end
    object GroupBox1: TGroupBox
      Left = 104
      Top = 56
      Width = 145
      Height = 97
      TabOrder = 1
      object Shape1: TShape
        Left = 9
        Top = 15
        Width = 129
        Height = 74
      end
    end
    object GroupBox3: TGroupBox
      Left = 808
      Top = 168
      Width = 153
      Height = 41
      TabOrder = 2
    end
  end
end
