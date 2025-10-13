object FrmWeapon_assignment_monitor: TFrmWeapon_assignment_monitor
  Left = 204
  Top = 210
  Width = 370
  Height = 190
  Caption = 'Weapon assignment monitor'
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
    Width = 361
    Height = 153
    Color = clMedGray
    TabOrder = 0
    object Label1: TLabel
      Left = 43
      Top = 16
      Width = 40
      Height = 13
      Alignment = taCenter
      Caption = 'WASA:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 91
      Top = 16
      Width = 86
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Auto assign'
      Color = clOlive
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 0
      Top = 40
      Width = 361
      Height = 2
    end
    object Label3: TLabel
      Left = 27
      Top = 56
      Width = 58
      Height = 13
      Alignment = taCenter
      Caption = 'Weapon1:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 27
      Top = 80
      Width = 58
      Height = 13
      Alignment = taCenter
      Caption = 'Weapon2:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 91
      Top = 56
      Width = 86
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Sensor1'
      Color = clGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label6: TLabel
      Left = 91
      Top = 80
      Width = 86
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Sensor2'
      Color = clGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label7: TLabel
      Left = 203
      Top = 56
      Width = 150
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Fire not authorized'
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label8: TLabel
      Left = 203
      Top = 80
      Width = 150
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Fire not authorized'
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Bevel2: TBevel
      Left = 0
      Top = 112
      Width = 361
      Height = 2
    end
    object Label9: TLabel
      Left = 107
      Top = 128
      Width = 150
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'CHECK FIRE'
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object VrDemoButton1: TVrDemoButton
      Left = 7
      Top = 120
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
      TabOrder = 0
    end
    object VrDemoButton2: TVrDemoButton
      Left = 287
      Top = 120
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
      TabOrder = 1
    end
  end
end
