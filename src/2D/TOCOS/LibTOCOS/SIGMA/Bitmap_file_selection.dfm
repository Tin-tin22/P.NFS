object FrmBtm_File_Sel: TFrmBtm_File_Sel
  Left = 212
  Top = 213
  Width = 317
  Height = 246
  Caption = 'Bitmap File Selection'
  Color = clMedGray
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWhite
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 305
    Height = 209
    Color = clMedGray
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 11
      Width = 72
      Height = 13
      Alignment = taCenter
      Caption = 'Bitmap files:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Bevel2: TBevel
      Left = 1
      Top = 165
      Width = 305
      Height = 2
    end
    object VrDemoButton5: TVrDemoButton
      Left = 121
      Top = 176
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
    object VrDemoButton6: TVrDemoButton
      Left = 313
      Top = 296
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
    object ListBox1: TListBox
      Left = 8
      Top = 32
      Width = 201
      Height = 121
      Color = clGray
      ItemHeight = 13
      Items.Strings = (
        'NA_1_1.bm'
        'NA_1.bm'
        'NA_2.bm'
        'NA_3.bm'
        'NA_4.bm'
        'NA_5.bm')
      TabOrder = 2
    end
    object VrDemoButton1: TVrDemoButton
      Left = 217
      Top = 32
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
      Caption = 'Edit'
      Color = clMedGray
      TabOrder = 3
    end
    object VrDemoButton2: TVrDemoButton
      Left = 217
      Top = 128
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
      Caption = 'System'
      Color = clMedGray
      TabOrder = 4
    end
  end
end
