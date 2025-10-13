object FrmTVvideo: TFrmTVvideo
  Left = 427
  Top = 146
  Width = 361
  Height = 384
  Caption = 'TV video - 2'
  Color = clMedGray
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 353
    Height = 329
    Color = clMedGray
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 272
      Width = 45
      Height = 13
      Alignment = taCenter
      Caption = 'Source:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 0
      Top = 291
      Width = 354
      Height = 2
    end
    object Label2: TLabel
      Left = 88
      Top = 272
      Width = 34
      Height = 13
      Alignment = taCenter
      Caption = 'mM25'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 144
      Top = 272
      Width = 29
      Height = 13
      Alignment = taCenter
      Caption = 'AScp'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 192
      Top = 272
      Width = 36
      Height = 13
      Alignment = taCenter
      Caption = 'Scale:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 256
      Top = 272
      Width = 18
      Height = 13
      Alignment = taCenter
      Caption = '0.5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 353
      Height = 265
      Color = clBlue
      Ctl3D = False
      ParentColor = False
      ParentCtl3D = False
      TabOrder = 0
    end
    object VrDemoButton1: TVrDemoButton
      Left = 9
      Top = 299
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
      TabOrder = 1
    end
    object VrDemoButton2: TVrDemoButton
      Left = 281
      Top = 299
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
      TabOrder = 2
    end
  end
  object MainMenu1: TMainMenu
    Left = 480
    Top = 128
    object Settings1: TMenuItem
      Caption = 'Settings'
    end
    object Picture1: TMenuItem
      Caption = 'Picture'
    end
  end
end
