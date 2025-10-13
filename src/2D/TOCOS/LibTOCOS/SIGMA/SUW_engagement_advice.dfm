object FrmSUW_engagement_advice: TFrmSUW_engagement_advice
  Left = 308
  Top = 160
  Width = 412
  Height = 301
  Caption = 'SUW engagement advice'
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
    Width = 401
    Height = 265
    Color = clMedGray
    TabOrder = 0
    object Label1: TLabel
      Left = 11
      Top = 64
      Width = 40
      Height = 13
      Alignment = taCenter
      Caption = 'Sensor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 0
      Top = 48
      Width = 401
      Height = 2
    end
    object Label2: TLabel
      Left = 104
      Top = 64
      Width = 46
      Height = 13
      Alignment = taCenter
      Caption = 'Weapon'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 211
      Top = 64
      Width = 36
      Height = 13
      Alignment = taCenter
      Caption = 'Status'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 315
      Top = 64
      Width = 26
      Height = 13
      Alignment = taCenter
      Caption = 'TTFF'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 107
      Top = 16
      Width = 42
      Height = 13
      Alignment = taCenter
      Caption = 'Target:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 21
      Top = 176
      Width = 32
      Height = 13
      Alignment = taCenter
      Caption = 'TTIZ:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 19
      Top = 200
      Width = 34
      Height = 13
      Alignment = taCenter
      Caption = 'TTEZ:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 56
      Top = 176
      Width = 40
      Height = 13
      Alignment = taCenter
      Caption = '00  00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 56
      Top = 200
      Width = 40
      Height = 13
      Alignment = taCenter
      Caption = '00  00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label10: TLabel
      Left = 125
      Top = 176
      Width = 27
      Height = 13
      Alignment = taCenter
      Caption = 'TTA:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 160
      Top = 176
      Width = 40
      Height = 13
      Alignment = taCenter
      Caption = '00  00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel
      Left = 235
      Top = 176
      Width = 31
      Height = 13
      Alignment = taCenter
      Caption = 'TTFF:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 235
      Top = 200
      Width = 31
      Height = 13
      Alignment = taCenter
      Caption = 'TTLF:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 272
      Top = 176
      Width = 40
      Height = 13
      Alignment = taCenter
      Caption = '00  00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label15: TLabel
      Left = 272
      Top = 200
      Width = 40
      Height = 13
      Alignment = taCenter
      Caption = '00  00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel2: TBevel
      Left = 0
      Top = 224
      Width = 401
      Height = 2
    end
    object ListBox1: TListBox
      Left = 8
      Top = 82
      Width = 385
      Height = 87
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ItemHeight = 13
      Items.Strings = (
        
          'SENS1              WEAPON1            NENG                  00  ' +
          ' 00'
        
          'SENS1              WEAPON2            WENG                 00   ' +
          '00'
        
          'SENS2              WEAPON2            ENG                    00 ' +
          '  00'
        
          'SENS2              WEAPON1            ENG                    00 ' +
          '  00'
        '')
      ParentFont = False
      TabOrder = 0
    end
    object VrDemoButton2: TVrDemoButton
      Left = 332
      Top = 232
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
    object VrDemoButton3: TVrDemoButton
      Left = 7
      Top = 232
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
      TabOrder = 2
    end
    object Edit1: TEdit
      Left = 159
      Top = 12
      Width = 58
      Height = 25
      AutoSize = False
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = 'A   1234'
    end
  end
end
