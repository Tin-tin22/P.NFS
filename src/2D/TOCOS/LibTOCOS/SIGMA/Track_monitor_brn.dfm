object FrmTrack_monitor_brn: TFrmTrack_monitor_brn
  Left = 212
  Top = 100
  Width = 394
  Height = 308
  Caption = 'Track monitor'
  Color = clMedGray
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 385
    Height = 273
    Color = clMedGray
    TabOrder = 0
    object Label1: TLabel
      Left = 11
      Top = 12
      Width = 99
      Height = 13
      Alignment = taCenter
      Caption = 'p_Trk Id Env C X'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 147
      Top = 12
      Width = 7
      Height = 13
      Alignment = taCenter
      Caption = 'Y'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 195
      Top = 12
      Width = 46
      Height = 13
      Alignment = taCenter
      Caption = 'Crs Spd'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 267
      Top = 12
      Width = 22
      Height = 13
      Alignment = taCenter
      Caption = 'H/D'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 323
      Top = 12
      Width = 22
      Height = 13
      Alignment = taCenter
      Caption = 'Priv'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 11
      Top = 92
      Width = 180
      Height = 13
      Alignment = taCenter
      Caption = 'b_Trk Id Env Type Brn Org:Brn'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 235
      Top = 92
      Width = 22
      Height = 13
      Alignment = taCenter
      Caption = 'Rng'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 0
      Top = 231
      Width = 385
      Height = 2
    end
    object Edit1: TEdit
      Left = 6
      Top = 32
      Width = 371
      Height = 57
      AutoSize = False
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'A2000 |H A    W 9999.9  9999.9  359 999.9    99900    ABCDE'
    end
    object Edit2: TEdit
      Left = 6
      Top = 112
      Width = 371
      Height = 57
      AutoSize = False
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object GroupBox1: TGroupBox
      Left = 16
      Top = 176
      Width = 193
      Height = 41
      TabOrder = 2
      object RadioButton1: TRadioButton
        Left = 15
        Top = 16
        Width = 73
        Height = 17
        Caption = 'Brn & Rng'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object RadioButton2: TRadioButton
        Left = 103
        Top = 16
        Width = 73
        Height = 17
        Caption = 'Surf. Grid'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
    object VrDemoButton1: TVrDemoButton
      Left = 216
      Top = 188
      Width = 160
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
      TabOrder = 3
    end
    object VrDemoButton2: TVrDemoButton
      Left = 6
      Top = 238
      Width = 64
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
      Caption = 'Quit'
      Color = clMedGray
      TabOrder = 4
    end
    object VrDemoButton3: TVrDemoButton
      Left = 313
      Top = 238
      Width = 64
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
      TabOrder = 5
    end
  end
end
