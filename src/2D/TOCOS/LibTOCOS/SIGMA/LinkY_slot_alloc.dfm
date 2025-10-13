object FrmLinkY_slot_alloc: TFrmLinkY_slot_alloc
  Left = 517
  Top = 275
  Width = 260
  Height = 210
  Caption = 'Link-Y slot alloc'
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
    Left = 1
    Top = 0
    Width = 248
    Height = 173
    Color = clMedGray
    TabOrder = 0
    object Label3: TLabel
      Left = 13
      Top = 11
      Width = 13
      Height = 14
      Alignment = taCenter
      Caption = 'PU'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Label2'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 70
      Top = 11
      Width = 28
      Height = 14
      Alignment = taCenter
      Caption = 'Tstart'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Label2'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 142
      Top = 11
      Width = 10
      Height = 14
      Alignment = taCenter
      Caption = 'Fr'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Label2'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 86
      Top = 107
      Width = 30
      Height = 14
      Alignment = taCenter
      Caption = 'Relay:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Label2'
      Font.Style = []
      ParentFont = False
    end
    object Bevel2: TBevel
      Left = -1
      Top = 128
      Width = 250
      Height = 2
    end
    object Label14: TLabel
      Left = 126
      Top = 107
      Width = 21
      Height = 14
      Alignment = taCenter
      Caption = 'Yes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Label2'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 198
      Top = 11
      Width = 13
      Height = 14
      Alignment = taCenter
      Caption = 'SF'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Label2'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = -9
      Top = 96
      Width = 258
      Height = 2
    end
    object ListBox1: TListBox
      Left = 8
      Top = 32
      Width = 233
      Height = 57
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ItemHeight = 13
      Items.Strings = (
        '21           00.0           100         10'
        '31'
        '42'
        ''
        '')
      ParentFont = False
      TabOrder = 0
    end
    object VrDemoButton1: TVrDemoButton
      Left = 5
      Top = 136
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
      Left = 184
      Top = 136
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
end
