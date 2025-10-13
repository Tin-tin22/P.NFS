object FrmPlot_Control: TFrmPlot_Control
  Left = 645
  Top = 105
  Width = 250
  Height = 261
  Caption = 'Plottable Control'
  Color = clGray
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = -2
    Top = 0
    Width = 243
    Height = 225
    Color = clMedGray
    TabOrder = 0
    object Label2: TLabel
      Left = 8
      Top = 11
      Width = 16
      Height = 13
      Alignment = taCenter
      Caption = 'Ch'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 40
      Top = 11
      Width = 47
      Height = 13
      Alignment = taCenter
      Caption = 'Track m'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 96
      Top = 11
      Width = 28
      Height = 13
      Alignment = taCenter
      Caption = 'Time'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 160
      Top = 33
      Width = 75
      Height = 13
      Alignment = taCenter
      Caption = 'Not Available'
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label6: TLabel
      Left = 160
      Top = 51
      Width = 74
      Height = 13
      Alignment = taCenter
      Caption = 'Channel free'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Bevel2: TBevel
      Left = 6
      Top = 189
      Width = 229
      Height = 1
    end
    object VrDemoButton1: TVrDemoButton
      Left = 160
      Top = 109
      Width = 65
      Height = 25
      FontEnter.Charset = DEFAULT_CHARSET
      FontEnter.Color = clWhite
      FontEnter.Height = -11
      FontEnter.Name = 'Verdana'
      FontEnter.Style = [fsBold]
      FontLeave.Charset = DEFAULT_CHARSET
      FontLeave.Color = clWhite
      FontLeave.Height = -11
      FontLeave.Name = 'Verdana'
      FontLeave.Style = [fsBold]
      Caption = 'Add'
      Color = clMedGray
      TabOrder = 0
    end
    object VrDemoButton2: TVrDemoButton
      Left = 160
      Top = 137
      Width = 65
      Height = 25
      FontEnter.Charset = DEFAULT_CHARSET
      FontEnter.Color = clWhite
      FontEnter.Height = -11
      FontEnter.Name = 'Verdana'
      FontEnter.Style = [fsBold]
      FontLeave.Charset = DEFAULT_CHARSET
      FontLeave.Color = clWhite
      FontLeave.Height = -11
      FontLeave.Name = 'Verdana'
      FontLeave.Style = [fsBold]
      Caption = 'Remove'
      Color = clMedGray
      TabOrder = 1
    end
    object VrDemoButton3: TVrDemoButton
      Left = 184
      Top = 194
      Width = 49
      Height = 25
      FontEnter.Charset = DEFAULT_CHARSET
      FontEnter.Color = clWhite
      FontEnter.Height = -11
      FontEnter.Name = 'Verdana'
      FontEnter.Style = [fsBold]
      FontLeave.Charset = DEFAULT_CHARSET
      FontLeave.Color = clWhite
      FontLeave.Height = -11
      FontLeave.Name = 'Verdana'
      FontLeave.Style = [fsBold]
      Caption = 'Help'
      Color = clMedGray
      TabOrder = 2
    end
    object Edit1: TEdit
      Left = 24
      Top = 164
      Width = 57
      Height = 21
      Color = clGray
      TabOrder = 3
    end
    object StaticText1: TStaticText
      Left = 8
      Top = 26
      Width = 145
      Height = 135
      AutoSize = False
      BorderStyle = sbsSunken
      Caption = '10'#13#10'11'#13#10'12'#13#10'13'#13#10'14'#13#10'15'#13#10'16'#13#10'17'#13#10'18'#13#10'19'
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 4
    end
  end
end
