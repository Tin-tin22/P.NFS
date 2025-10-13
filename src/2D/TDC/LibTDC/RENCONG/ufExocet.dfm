object frmExocet_Rencong: TfrmExocet_Rencong
  Left = 214
  Top = 126
  Width = 696
  Height = 480
  Caption = 'EXOCET'
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
    Top = 6
    Width = 841
    Height = 1200
    Caption = 'Panel1'
    Color = clMoneyGreen
    TabOrder = 0
    object Bevel1: TBevel
      Left = 84
      Top = 134
      Width = 59
      Height = 11
      Shape = bsBottomLine
    end
    object Label2: TLabel
      Left = 223
      Top = 123
      Width = 33
      Height = 13
      Caption = 'SAFE'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel3: TBevel
      Left = 219
      Top = 134
      Width = 117
      Height = 11
      Shape = bsBottomLine
    end
    object Label3: TLabel
      Left = 673
      Top = 125
      Width = 33
      Height = 13
      Caption = 'SAFE'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel5: TBevel
      Left = 669
      Top = 134
      Width = 59
      Height = 11
      Shape = bsBottomLine
    end
    object Bevel6: TBevel
      Left = 622
      Top = 90
      Width = 9
      Height = 18
      Shape = bsLeftLine
    end
    object Label4: TLabel
      Left = 806
      Top = 130
      Width = 33
      Height = 13
      Caption = 'SAFE'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel8: TBevel
      Left = 767
      Top = 89
      Width = 9
      Height = 18
      Shape = bsLeftLine
    end
    object Label5: TLabel
      Left = 361
      Top = 136
      Width = 71
      Height = 13
      Caption = 'ISOLATION'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel9: TBevel
      Left = 465
      Top = 134
      Width = 117
      Height = 11
      Shape = bsBottomLine
    end
    object Label6: TLabel
      Left = 7
      Top = 328
      Width = 26
      Height = 13
      Caption = 'RUN'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel11: TBevel
      Left = 39
      Top = 320
      Width = 9
      Height = 26
      Shape = bsLeftLine
    end
    object Bevel12: TBevel
      Left = 40
      Top = 313
      Width = 296
      Height = 11
      Shape = bsBottomLine
    end
    object Label7: TLabel
      Left = 135
      Top = 328
      Width = 26
      Height = 13
      Caption = 'RUN'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel14: TBevel
      Left = 183
      Top = 321
      Width = 9
      Height = 26
      Shape = bsLeftLine
    end
    object Label8: TLabel
      Left = 346
      Top = 312
      Width = 99
      Height = 13
      Caption = 'MISSILE GYROS'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object SwtrPumpAuxOn: TVrBlinkLed
      Left = 29
      Top = 418
      Width = 26
      Height = 27
      Palette1.Low = clBlack
      Palette1.High = clNavy
      Palette2.Low = clBlack
      Palette2.High = clAqua
      Palette3.Low = clBlack
      Palette3.High = clYellow
      Palette4.Low = clBlack
      Palette4.High = clLime
      Margin = 2
      Spacing = 3
      Color = clSkyBlue
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
      Left = 171
      Top = 418
      Width = 26
      Height = 27
      Palette1.Low = clBlack
      Palette1.High = clNavy
      Palette2.Low = clBlack
      Palette2.High = clAqua
      Palette3.Low = clBlack
      Palette3.High = clYellow
      Palette4.Low = clBlack
      Palette4.High = clLime
      Margin = 2
      Spacing = 3
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      BlinkSpeed = 500
    end
    object VrBlinkLed2: TVrBlinkLed
      Left = 29
      Top = 454
      Width = 26
      Height = 27
      Palette1.Low = clBlack
      Palette1.High = clNavy
      Palette2.Low = clBlack
      Palette2.High = clAqua
      Palette3.Low = clBlack
      Palette3.High = clYellow
      Palette4.Low = clBlack
      Palette4.High = clLime
      Margin = 2
      Spacing = 3
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      BlinkSpeed = 500
    end
    object VrBlinkLed3: TVrBlinkLed
      Left = 171
      Top = 454
      Width = 26
      Height = 27
      Palette1.Low = clBlack
      Palette1.High = clNavy
      Palette2.Low = clBlack
      Palette2.High = clAqua
      Palette3.Low = clBlack
      Palette3.High = clYellow
      Palette4.Low = clBlack
      Palette4.High = clLime
      Margin = 2
      Spacing = 3
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      BlinkSpeed = 500
    end
    object Bevel15: TBevel
      Left = 3
      Top = 436
      Width = 301
      Height = 11
      Shape = bsBottomLine
    end
    object Bevel17: TBevel
      Left = 38
      Top = 486
      Width = 9
      Height = 15
      Shape = bsLeftLine
    end
    object Bevel18: TBevel
      Left = 39
      Top = 478
      Width = 66
      Height = 11
      Shape = bsBottomLine
    end
    object Bevel20: TBevel
      Left = 185
      Top = 487
      Width = 9
      Height = 14
      Shape = bsLeftLine
    end
    object Label11: TLabel
      Left = 105
      Top = 481
      Width = 25
      Height = 13
      Caption = 'AIM'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel21: TBevel
      Left = 135
      Top = 479
      Width = 49
      Height = 11
      Shape = bsBottomLine
    end
    object Label1: TLabel
      Left = 88
      Top = 122
      Width = 33
      Height = 13
      Caption = 'SAFE'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object VrBlinkLed4: TVrBlinkLed
      Left = 170
      Top = 568
      Width = 26
      Height = 27
      Palette1.Low = clBlack
      Palette1.High = clNavy
      Palette2.Low = clBlack
      Palette2.High = clAqua
      Palette3.Low = clBlack
      Palette3.High = clYellow
      Palette4.Low = clBlack
      Palette4.High = clLime
      Margin = 2
      Spacing = 3
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      BlinkSpeed = 500
    end
    object VrBlinkLed5: TVrBlinkLed
      Left = 28
      Top = 568
      Width = 26
      Height = 27
      Palette1.Low = clBlack
      Palette1.High = clNavy
      Palette2.Low = clBlack
      Palette2.High = clAqua
      Palette3.Low = clBlack
      Palette3.High = clYellow
      Palette4.Low = clBlack
      Palette4.High = clLime
      Margin = 2
      Spacing = 3
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      BlinkSpeed = 500
    end
    object Label20: TLabel
      Left = 592
      Top = 328
      Width = 26
      Height = 13
      Caption = 'RUN'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel2: TBevel
      Left = 624
      Top = 320
      Width = 9
      Height = 26
      Shape = bsLeftLine
    end
    object Bevel4: TBevel
      Left = 455
      Top = 313
      Width = 312
      Height = 11
      Shape = bsBottomLine
    end
    object Label21: TLabel
      Left = 720
      Top = 328
      Width = 26
      Height = 13
      Caption = 'RUN'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel10: TBevel
      Left = 768
      Top = 321
      Width = 9
      Height = 26
      Shape = bsLeftLine
    end
    object VrBlinkLed6: TVrBlinkLed
      Left = 613
      Top = 418
      Width = 26
      Height = 27
      Palette1.Low = clBlack
      Palette1.High = clNavy
      Palette2.Low = clBlack
      Palette2.High = clAqua
      Palette3.Low = clBlack
      Palette3.High = clYellow
      Palette4.Low = clBlack
      Palette4.High = clLime
      Margin = 2
      Spacing = 3
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      BlinkSpeed = 500
    end
    object VrBlinkLed7: TVrBlinkLed
      Left = 755
      Top = 418
      Width = 26
      Height = 27
      Palette1.Low = clBlack
      Palette1.High = clNavy
      Palette2.Low = clBlack
      Palette2.High = clAqua
      Palette3.Low = clBlack
      Palette3.High = clYellow
      Palette4.Low = clBlack
      Palette4.High = clLime
      Margin = 2
      Spacing = 3
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      BlinkSpeed = 500
    end
    object VrBlinkLed8: TVrBlinkLed
      Left = 613
      Top = 454
      Width = 26
      Height = 27
      Palette1.Low = clBlack
      Palette1.High = clNavy
      Palette2.Low = clBlack
      Palette2.High = clAqua
      Palette3.Low = clBlack
      Palette3.High = clYellow
      Palette4.Low = clBlack
      Palette4.High = clLime
      Margin = 2
      Spacing = 3
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      BlinkSpeed = 500
    end
    object VrBlinkLed9: TVrBlinkLed
      Left = 755
      Top = 454
      Width = 26
      Height = 27
      Palette1.Low = clBlack
      Palette1.High = clNavy
      Palette2.Low = clBlack
      Palette2.High = clAqua
      Palette3.Low = clBlack
      Palette3.High = clYellow
      Palette4.Low = clBlack
      Palette4.High = clLime
      Margin = 2
      Spacing = 3
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      BlinkSpeed = 500
    end
    object Bevel13: TBevel
      Left = 504
      Top = 436
      Width = 301
      Height = 11
      Shape = bsBottomLine
    end
    object Bevel16: TBevel
      Left = 622
      Top = 486
      Width = 9
      Height = 15
      Shape = bsLeftLine
    end
    object Bevel19: TBevel
      Left = 623
      Top = 478
      Width = 66
      Height = 11
      Shape = bsBottomLine
    end
    object Bevel22: TBevel
      Left = 769
      Top = 487
      Width = 9
      Height = 14
      Shape = bsLeftLine
    end
    object Label22: TLabel
      Left = 689
      Top = 481
      Width = 25
      Height = 13
      Caption = 'AIM'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel23: TBevel
      Left = 719
      Top = 479
      Width = 49
      Height = 11
      Shape = bsBottomLine
    end
    object VrBlinkLed10: TVrBlinkLed
      Left = 755
      Top = 567
      Width = 26
      Height = 27
      Palette1.Low = clBlack
      Palette1.High = clNavy
      Palette2.Low = clBlack
      Palette2.High = clAqua
      Palette3.Low = clBlack
      Palette3.High = clYellow
      Palette4.Low = clBlack
      Palette4.High = clLime
      Margin = 2
      Spacing = 3
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      BlinkSpeed = 500
    end
    object VrBlinkLed11: TVrBlinkLed
      Left = 613
      Top = 567
      Width = 26
      Height = 27
      Palette1.Low = clBlack
      Palette1.High = clNavy
      Palette2.Low = clBlack
      Palette2.High = clAqua
      Palette3.Low = clBlack
      Palette3.High = clYellow
      Palette4.Low = clBlack
      Palette4.High = clLime
      Margin = 2
      Spacing = 3
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      BlinkSpeed = 500
    end
    object VrBitmapButton3: TVrBitmapButton
      Left = 23
      Top = 201
      Width = 49
      Height = 43
      TransparentMode = tmPixel
      Transparent = True
    end
    object VrBitmapButton4: TVrBitmapButton
      Left = 159
      Top = 201
      Width = 49
      Height = 43
      TransparentMode = tmPixel
      Transparent = True
    end
    object Bevel7: TBevel
      Left = 43
      Top = 182
      Width = 293
      Height = 11
      Shape = bsBottomLine
    end
    object Bevel24: TBevel
      Left = 464
      Top = 182
      Width = 293
      Height = 11
      Shape = bsBottomLine
    end
    object Label34: TLabel
      Left = 361
      Top = 184
      Width = 62
      Height = 13
      Caption = 'IGNITERS'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object VrBitmapButton6: TVrBitmapButton
      Left = 607
      Top = 200
      Width = 49
      Height = 43
      TransparentMode = tmPixel
      Transparent = True
    end
    object VrBitmapButton7: TVrBitmapButton
      Left = 743
      Top = 200
      Width = 49
      Height = 43
      TransparentMode = tmPixel
      Transparent = True
    end
    object VrBlinkLed22: TVrBlinkLed
      Left = 21
      Top = 254
      Width = 26
      Height = 27
      Palette1.Low = clBlack
      Palette1.High = clNavy
      Palette2.Low = clBlack
      Palette2.High = clAqua
      Palette3.Low = clBlack
      Palette3.High = clYellow
      Palette4.Low = clBlack
      Palette4.High = clLime
      Margin = 2
      Spacing = 3
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      BlinkSpeed = 500
    end
    object VrBlinkLed23: TVrBlinkLed
      Left = 69
      Top = 274
      Width = 26
      Height = 27
      Palette1.Low = clBlack
      Palette1.High = clNavy
      Palette2.Low = clBlack
      Palette2.High = clAqua
      Palette3.Low = clBlack
      Palette3.High = clYellow
      Palette4.Low = clBlack
      Palette4.High = clLime
      Margin = 2
      Spacing = 3
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      BlinkSpeed = 500
    end
    object VrBlinkLed24: TVrBlinkLed
      Left = 141
      Top = 254
      Width = 26
      Height = 27
      Palette1.Low = clBlack
      Palette1.High = clNavy
      Palette2.Low = clBlack
      Palette2.High = clAqua
      Palette3.Low = clBlack
      Palette3.High = clYellow
      Palette4.Low = clBlack
      Palette4.High = clLime
      Margin = 2
      Spacing = 3
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      BlinkSpeed = 500
    end
    object VrBlinkLed25: TVrBlinkLed
      Left = 189
      Top = 274
      Width = 26
      Height = 27
      Palette1.Low = clBlack
      Palette1.High = clNavy
      Palette2.Low = clBlack
      Palette2.High = clAqua
      Palette3.Low = clBlack
      Palette3.High = clYellow
      Palette4.Low = clBlack
      Palette4.High = clLime
      Margin = 2
      Spacing = 3
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      BlinkSpeed = 500
    end
    object VrBlinkLed26: TVrBlinkLed
      Left = 605
      Top = 276
      Width = 26
      Height = 27
      Palette1.Low = clBlack
      Palette1.High = clNavy
      Palette2.Low = clBlack
      Palette2.High = clAqua
      Palette3.Low = clBlack
      Palette3.High = clYellow
      Palette4.Low = clBlack
      Palette4.High = clLime
      Margin = 2
      Spacing = 3
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      BlinkSpeed = 500
    end
    object VrBlinkLed27: TVrBlinkLed
      Left = 653
      Top = 256
      Width = 26
      Height = 27
      Palette1.Low = clBlack
      Palette1.High = clNavy
      Palette2.Low = clBlack
      Palette2.High = clAqua
      Palette3.Low = clBlack
      Palette3.High = clYellow
      Palette4.Low = clBlack
      Palette4.High = clLime
      Margin = 2
      Spacing = 3
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      BlinkSpeed = 500
    end
    object VrBlinkLed28: TVrBlinkLed
      Left = 725
      Top = 276
      Width = 26
      Height = 27
      Palette1.Low = clBlack
      Palette1.High = clNavy
      Palette2.Low = clBlack
      Palette2.High = clAqua
      Palette3.Low = clBlack
      Palette3.High = clYellow
      Palette4.Low = clBlack
      Palette4.High = clLime
      Margin = 2
      Spacing = 3
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      BlinkSpeed = 500
    end
    object VrBlinkLed29: TVrBlinkLed
      Left = 773
      Top = 256
      Width = 26
      Height = 27
      Palette1.Low = clBlack
      Palette1.High = clNavy
      Palette2.Low = clBlack
      Palette2.High = clAqua
      Palette3.Low = clBlack
      Palette3.High = clYellow
      Palette4.Low = clBlack
      Palette4.High = clLime
      Margin = 2
      Spacing = 3
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      BlinkSpeed = 500
    end
    object Bevel25: TBevel
      Left = 32
      Top = 245
      Width = 309
      Height = 11
      Shape = bsBottomLine
    end
    object Label35: TLabel
      Left = 350
      Top = 247
      Width = 104
      Height = 13
      Caption = 'CHANNEL FAULT'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel26: TBevel
      Left = 479
      Top = 245
      Width = 309
      Height = 11
      Shape = bsBottomLine
    end
    object Bevel27: TBevel
      Left = 79
      Top = 292
      Width = 258
      Height = 11
      Shape = bsBottomLine
    end
    object Label36: TLabel
      Left = 370
      Top = 294
      Width = 60
      Height = 13
      Caption = 'WARM UP'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel28: TBevel
      Left = 475
      Top = 292
      Width = 261
      Height = 11
      Shape = bsBottomLine
    end
    object VrBitmapButton8: TVrBitmapButton
      Left = 89
      Top = 604
      Width = 49
      Height = 42
      TransparentMode = tmPixel
      Transparent = True
    end
    object VrBitmapButton9: TVrBitmapButton
      Left = 25
      Top = 638
      Width = 49
      Height = 42
      TransparentMode = tmPixel
      Transparent = True
    end
    object VrBitmapButton10: TVrBitmapButton
      Left = 153
      Top = 638
      Width = 49
      Height = 42
      TransparentMode = tmPixel
      Transparent = True
    end
    object Label37: TLabel
      Left = 88
      Top = 577
      Width = 51
      Height = 26
      Caption = 'LAUNCH'#13#10'  GATE'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label38: TLabel
      Left = 99
      Top = 654
      Width = 30
      Height = 13
      Caption = 'FIRE'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object VrBitmapButton11: TVrBitmapButton
      Left = 673
      Top = 604
      Width = 49
      Height = 42
      TransparentMode = tmPixel
      Transparent = True
    end
    object VrBitmapButton12: TVrBitmapButton
      Left = 609
      Top = 638
      Width = 49
      Height = 42
      TransparentMode = tmPixel
      Transparent = True
    end
    object VrBitmapButton13: TVrBitmapButton
      Left = 737
      Top = 638
      Width = 49
      Height = 42
      TransparentMode = tmPixel
      Transparent = True
    end
    object Label39: TLabel
      Left = 672
      Top = 577
      Width = 51
      Height = 26
      Caption = 'LAUNCH'#13#10'  GATE'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label40: TLabel
      Left = 683
      Top = 654
      Width = 30
      Height = 13
      Caption = 'FIRE'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label41: TLabel
      Left = 368
      Top = 625
      Width = 75
      Height = 13
      Caption = 'CHECK FIRE'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object VrBitmapButton14: TVrBitmapButton
      Left = 377
      Top = 638
      Width = 49
      Height = 42
      TransparentMode = tmPixel
      Transparent = True
    end
    object Bevel29: TBevel
      Left = -5
      Top = 676
      Width = 821
      Height = 11
      Shape = bsBottomLine
    end
    object VrBlinkLed30: TVrBlinkLed
      Left = 397
      Top = 1101
      Width = 26
      Height = 27
      Palette1.Low = clBlack
      Palette1.High = clNavy
      Palette2.Low = clBlack
      Palette2.High = clAqua
      Palette3.Low = clBlack
      Palette3.High = clYellow
      Palette4.Low = clBlack
      Palette4.High = clLime
      Margin = 2
      Spacing = 3
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      BlinkSpeed = 500
    end
    object Label43: TLabel
      Left = 216
      Top = 1106
      Width = 81
      Height = 26
      Caption = 'LAMP '#13#10'BRIGHTNESS'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label44: TLabel
      Left = 552
      Top = 1106
      Width = 81
      Height = 26
      Alignment = taRightJustify
      Caption = 'LEGEND '#13#10'BRIGHTNESS'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label45: TLabel
      Left = 371
      Top = 1082
      Width = 78
      Height = 13
      Alignment = taRightJustify
      Caption = ' TESTLAMPS'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object VrRotarySwitch1: TVrRotarySwitch
      Left = 7
      Top = 106
      Width = 80
      Height = 74
      Radius = 30
      SwitchPositions.Strings = (
        ' '
        ' ')
      SwitchAngleStart = 180
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
    end
    object VrRotarySwitch2: TVrRotarySwitch
      Left = 143
      Top = 106
      Width = 80
      Height = 74
      Radius = 30
      SwitchPositions.Strings = (
        ' '
        ' ')
      SwitchAngleStart = 180
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
    end
    object VrRotarySwitch3: TVrRotarySwitch
      Left = 583
      Top = 106
      Width = 80
      Height = 74
      Radius = 30
      SwitchPositions.Strings = (
        ' '
        ' ')
      SwitchAngleStart = 180
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
    end
    object VrRotarySwitch4: TVrRotarySwitch
      Left = 727
      Top = 106
      Width = 80
      Height = 74
      Radius = 30
      SwitchPositions.Strings = (
        ' '
        ' ')
      SwitchAngleStart = 180
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
    end
    object VrRotarySwitch5: TVrRotarySwitch
      Left = -1
      Top = 344
      Width = 80
      Height = 74
      Radius = 30
      SwitchPositions.Strings = (
        ' '
        ' ')
      SwitchAngleStart = 180
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
    end
    object VrRotarySwitch6: TVrRotarySwitch
      Left = 143
      Top = 344
      Width = 80
      Height = 74
      Radius = 30
      SwitchPositions.Strings = (
        ' '
        ' ')
      SwitchAngleStart = 180
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
    end
    object VrRotarySwitch7: TVrRotarySwitch
      Left = -2
      Top = 491
      Width = 80
      Height = 74
      Radius = 30
      SwitchPositions.Strings = (
        ' '
        ' ')
      SwitchPosition = 1
      SwitchAngleStart = 180
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
    end
    object VrRotarySwitch8: TVrRotarySwitch
      Left = 145
      Top = 492
      Width = 80
      Height = 74
      Radius = 30
      SwitchPositions.Strings = (
        ' '
        ' ')
      SwitchPosition = 1
      SwitchAngleStart = 180
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
    end
    object GroupBox1: TGroupBox
      Left = 15
      Top = 687
      Width = 193
      Height = 376
      TabOrder = 8
      object Label15: TLabel
        Left = 13
        Top = 295
        Width = 43
        Height = 26
        Caption = 'PRESET'#13#10'SMALL'
      end
      object Label16: TLabel
        Left = 139
        Top = 295
        Width = 43
        Height = 26
        Caption = 'PRESET'#13#10'LARGE'
      end
      object Label17: TLabel
        Left = 16
        Top = 9
        Width = 71
        Height = 13
        Caption = 'PROXIMITY'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label18: TLabel
        Left = 120
        Top = 17
        Width = 29
        Height = 13
        Caption = 'FUSE'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 56
        Top = 234
        Width = 88
        Height = 13
        Caption = 'SEARCH AREA'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label42: TLabel
        Left = 66
        Top = 126
        Width = 64
        Height = 13
        Caption = 'ALTITUDE'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object VrRotarySwitch14: TVrRotarySwitch
        Left = 26
        Top = 33
        Width = 145
        Height = 94
        Radius = 30
        SwitchPositions.Strings = (
          'ON'
          'OFF')
        SwitchPosition = 1
        SwitchAngleStart = 180
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
      end
      object VrRotarySwitch15: TVrRotarySwitch
        Left = 21
        Top = 148
        Width = 153
        Height = 88
        Radius = 30
        SwitchPositions.Strings = (
          'LOW'
          'MEDIUM'
          'HIGH')
        SwitchPosition = 1
        SwitchAngleStart = 90
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
      end
      object VrRotarySwitch16: TVrRotarySwitch
        Left = 57
        Top = 246
        Width = 81
        Height = 120
        Radius = 30
        SwitchPositions.Strings = (
          'MANUAL'
          ''
          'NO RANGE'
          ' ')
        SwitchPosition = 1
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
      end
    end
    object GroupBox2: TGroupBox
      Left = 615
      Top = 687
      Width = 193
      Height = 377
      TabOrder = 9
      object Label13: TLabel
        Left = 49
        Top = 9
        Width = 86
        Height = 13
        Caption = 'RANGE TO GO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label19: TLabel
        Left = 58
        Top = 234
        Width = 71
        Height = 13
        Caption = 'SELECTION'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label12: TLabel
        Left = 48
        Top = 122
        Width = 101
        Height = 13
        Caption = 'MANUAL WIDTH'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object VrRotarySwitch12: TVrRotarySwitch
        Left = 8
        Top = 148
        Width = 161
        Height = 88
        Radius = 30
        SwitchPositions.Strings = (
          'SMALL'
          'MEDIUM'
          'LARGE')
        SwitchPosition = 1
        SwitchAngleStart = 90
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
      end
      object VrRotarySwitch13: TVrRotarySwitch
        Left = 8
        Top = 255
        Width = 169
        Height = 120
        Radius = 30
        SwitchPositions.Strings = (
          'PANEL'
          'SMALL'
          ' '
          'LARGE')
        SwitchPosition = 1
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        object Label10: TLabel
          Left = 55
          Top = -1
          Width = 47
          Height = 26
          Caption = 'DEPTH'#13#10'MEDIUM'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
      end
      object VrRotarySwitch11: TVrRotarySwitch
        Left = 14
        Top = 34
        Width = 153
        Height = 88
        Radius = 30
        SwitchPositions.Strings = (
          'SMALL'
          'MEDIUM'
          'LARGE')
        SwitchPosition = 1
        SwitchAngleStart = 90
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
      end
    end
    object GroupBox3: TGroupBox
      Left = 311
      Top = 328
      Width = 185
      Height = 266
      TabOrder = 10
      object Label9: TLabel
        Left = 28
        Top = 117
        Width = 133
        Height = 13
        Caption = 'TARGET INDICATION'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object VrRotarySwitch9: TVrRotarySwitch
        Left = 8
        Top = 14
        Width = 169
        Height = 91
        Radius = 30
        SwitchPositions.Strings = (
          'PORT'
          'OFF'
          'SIBD')
        SwitchPosition = 1
        SwitchAngleStart = 90
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
      end
      object VrRotarySwitch10: TVrRotarySwitch
        Left = 8
        Top = 137
        Width = 169
        Height = 120
        Radius = 30
        SwitchPositions.Strings = (
          'HAND'
          'VISUAL'
          'OFF'
          'BLIND')
        SwitchPosition = 2
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
      end
    end
    object VrRotarySwitch17: TVrRotarySwitch
      Left = 584
      Top = 344
      Width = 80
      Height = 74
      Radius = 30
      SwitchPositions.Strings = (
        ' '
        ' ')
      SwitchAngleStart = 180
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
    end
    object VrRotarySwitch18: TVrRotarySwitch
      Left = 728
      Top = 344
      Width = 80
      Height = 74
      Radius = 30
      SwitchPositions.Strings = (
        ' '
        ' ')
      SwitchAngleStart = 180
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
    end
    object VrRotarySwitch19: TVrRotarySwitch
      Left = 582
      Top = 492
      Width = 80
      Height = 74
      Radius = 30
      SwitchPositions.Strings = (
        ' '
        ' ')
      SwitchPosition = 1
      SwitchAngleStart = 180
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
    end
    object VrRotarySwitch20: TVrRotarySwitch
      Left = 729
      Top = 493
      Width = 80
      Height = 74
      Radius = 30
      SwitchPositions.Strings = (
        ' '
        ' ')
      SwitchPosition = 1
      SwitchAngleStart = 180
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
    end
    object GroupBox4: TGroupBox
      Left = 7
      Top = 2
      Width = 153
      Height = 101
      TabOrder = 15
      object Label23: TLabel
        Left = 23
        Top = 15
        Width = 18
        Height = 13
        Caption = 'ON'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object VrBitmapButton1: TVrBitmapButton
        Left = 56
        Top = 36
        Width = 49
        Height = 42
        TransparentMode = tmPixel
        Transparent = True
      end
      object Label24: TLabel
        Left = 71
        Top = 15
        Width = 25
        Height = 13
        Caption = 'OFF'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object VrBlinkLed12: TVrBlinkLed
        Left = 119
        Top = 43
        Width = 26
        Height = 26
        Palette1.Low = clBlack
        Palette1.High = clNavy
        Palette2.Low = clBlack
        Palette2.High = clAqua
        Palette3.Low = clBlack
        Palette3.High = clYellow
        Palette4.Low = clBlack
        Palette4.High = clLime
        Margin = 2
        Spacing = 3
        Color = clSkyBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        BlinkSpeed = 500
      end
      object VrBitmapButton15: TVrBitmapButton
        Left = 8
        Top = 36
        Width = 49
        Height = 42
        TransparentMode = tmPixel
        Transparent = True
      end
    end
    object GroupBox5: TGroupBox
      Left = 159
      Top = 2
      Width = 129
      Height = 101
      TabOrder = 16
      object Label25: TLabel
        Left = 19
        Top = 10
        Width = 18
        Height = 13
        Caption = 'ON'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label26: TLabel
        Left = 80
        Top = 10
        Width = 25
        Height = 13
        Caption = 'OFF'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object VrBlinkLed13: TVrBlinkLed
        Left = 15
        Top = 23
        Width = 26
        Height = 26
        Palette1.Low = clBlack
        Palette1.High = clNavy
        Palette2.Low = clBlack
        Palette2.High = clAqua
        Palette3.Low = clBlack
        Palette3.High = clYellow
        Palette4.Low = clBlack
        Palette4.High = clLime
        Margin = 2
        Spacing = 3
        Color = clSkyBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        BlinkSpeed = 500
      end
      object VrBlinkLed14: TVrBlinkLed
        Left = 43
        Top = 60
        Width = 42
        Height = 34
        Palette1.Low = clBlack
        Palette1.High = clNavy
        Palette2.Low = clBlack
        Palette2.High = clAqua
        Palette3.Low = clBlack
        Palette3.High = clYellow
        Palette4.Low = clBlack
        Palette4.High = clLime
        Margin = 2
        Spacing = 3
        Color = clSkyBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        BlinkSpeed = 500
      end
      object VrBlinkLed15: TVrBlinkLed
        Left = 79
        Top = 23
        Width = 26
        Height = 26
        Palette1.Low = clBlack
        Palette1.High = clNavy
        Palette2.Low = clBlack
        Palette2.High = clAqua
        Palette3.Low = clBlack
        Palette3.High = clYellow
        Palette4.Low = clBlack
        Palette4.High = clLime
        Margin = 2
        Spacing = 3
        Color = clSkyBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        BlinkSpeed = 500
      end
      object Label27: TLabel
        Left = 16
        Top = 49
        Width = 95
        Height = 13
        Caption = 'SYSTEM FAULT'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object GroupBox6: TGroupBox
      Left = 287
      Top = 2
      Width = 241
      Height = 101
      TabOrder = 17
      object VrBlinkLed16: TVrBlinkLed
        Left = 7
        Top = 39
        Width = 26
        Height = 26
        Palette1.Low = clBlack
        Palette1.High = clNavy
        Palette2.Low = clBlack
        Palette2.High = clAqua
        Palette3.Low = clBlack
        Palette3.High = clYellow
        Palette4.Low = clBlack
        Palette4.High = clLime
        Margin = 2
        Spacing = 3
        Color = clSkyBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        BlinkSpeed = 500
      end
      object VrBlinkLed18: TVrBlinkLed
        Left = 199
        Top = 39
        Width = 26
        Height = 26
        Palette1.Low = clBlack
        Palette1.High = clNavy
        Palette2.Low = clBlack
        Palette2.High = clAqua
        Palette3.Low = clBlack
        Palette3.High = clYellow
        Palette4.Low = clBlack
        Palette4.High = clLime
        Margin = 2
        Spacing = 3
        Color = clSkyBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        BlinkSpeed = 500
      end
      object VrRotarySwitch21: TVrRotarySwitch
        Left = 57
        Top = 9
        Width = 129
        Height = 89
        Radius = 30
        SwitchPositions.Strings = (
          'TEST'
          'ACTION')
        SwitchAngleStart = 90
        SwitchAngleEnd = 180
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
      end
    end
    object GroupBox7: TGroupBox
      Left = 527
      Top = 2
      Width = 129
      Height = 101
      TabOrder = 18
      object Label28: TLabel
        Left = 11
        Top = 10
        Width = 42
        Height = 13
        Caption = 'GYRO1'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label29: TLabel
        Left = 80
        Top = 10
        Width = 25
        Height = 13
        Caption = 'LOG'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object VrBlinkLed17: TVrBlinkLed
        Left = 15
        Top = 23
        Width = 26
        Height = 26
        Palette1.Low = clBlack
        Palette1.High = clNavy
        Palette2.Low = clBlack
        Palette2.High = clAqua
        Palette3.Low = clBlack
        Palette3.High = clYellow
        Palette4.Low = clBlack
        Palette4.High = clLime
        Margin = 2
        Spacing = 3
        Color = clSkyBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        BlinkSpeed = 500
      end
      object VrBlinkLed20: TVrBlinkLed
        Left = 79
        Top = 23
        Width = 26
        Height = 26
        Palette1.Low = clBlack
        Palette1.High = clNavy
        Palette2.Low = clBlack
        Palette2.High = clAqua
        Palette3.Low = clBlack
        Palette3.High = clYellow
        Palette4.Low = clBlack
        Palette4.High = clLime
        Margin = 2
        Spacing = 3
        Color = clSkyBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        BlinkSpeed = 500
      end
      object VrBlinkLed19: TVrBlinkLed
        Left = 15
        Top = 64
        Width = 26
        Height = 26
        Palette1.Low = clBlack
        Palette1.High = clNavy
        Palette2.Low = clBlack
        Palette2.High = clAqua
        Palette3.Low = clBlack
        Palette3.High = clYellow
        Palette4.Low = clBlack
        Palette4.High = clLime
        Margin = 2
        Spacing = 3
        Color = clSkyBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        BlinkSpeed = 500
      end
      object Label30: TLabel
        Left = 11
        Top = 51
        Width = 42
        Height = 13
        Caption = 'GYRO2'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object VrBlinkLed21: TVrBlinkLed
        Left = 79
        Top = 64
        Width = 26
        Height = 26
        Palette1.Low = clBlack
        Palette1.High = clNavy
        Palette2.Low = clBlack
        Palette2.High = clAqua
        Palette3.Low = clBlack
        Palette3.High = clYellow
        Palette4.Low = clBlack
        Palette4.High = clLime
        Margin = 2
        Spacing = 3
        Color = clSkyBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        BlinkSpeed = 500
      end
      object Label32: TLabel
        Left = 84
        Top = 51
        Width = 15
        Height = 13
        Caption = 'TL'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object GroupBox8: TGroupBox
      Left = 655
      Top = 2
      Width = 153
      Height = 101
      TabOrder = 19
      object VrBitmapButton2: TVrBitmapButton
        Left = 64
        Top = 134
        Width = 49
        Height = 42
        Glyph.Data = {
          46090000424D4609000000000000360400002800000024000000240000000100
          0800000000001005000000000000000000000001000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
          A6000020400000206000002080000020A0000020C0000020E000004000000040
          20000040400000406000004080000040A0000040C0000040E000006000000060
          20000060400000606000006080000060A0000060C0000060E000008000000080
          20000080400000806000008080000080A0000080C0000080E00000A0000000A0
          200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
          200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
          200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
          20004000400040006000400080004000A0004000C0004000E000402000004020
          20004020400040206000402080004020A0004020C0004020E000404000004040
          20004040400040406000404080004040A0004040C0004040E000406000004060
          20004060400040606000406080004060A0004060C0004060E000408000004080
          20004080400040806000408080004080A0004080C0004080E00040A0000040A0
          200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
          200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
          200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
          20008000400080006000800080008000A0008000C0008000E000802000008020
          20008020400080206000802080008020A0008020C0008020E000804000008040
          20008040400080406000804080008040A0008040C0008040E000806000008060
          20008060400080606000806080008060A0008060C0008060E000808000008080
          20008080400080806000808080008080A0008080C0008080E00080A0000080A0
          200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
          200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
          200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
          2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
          2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
          2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
          2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
          2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
          2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
          2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FDFDFDFDFDFD
          FDFDFDFDFDFDC6C683000A1000504252C7C6FDFDFDFDFDFDFDFDFDFDFDFDFDFD
          FDFDFDFDFDFDFDFD83855A58EDF7F7F7F7F7ADF750528385FDFDFDFDFDFDFDFD
          FDFDFDFDFDFDFDFDFDFDFD42AB5BF5F7B6EEF5EEF5EEEDABF7B55AAB42FDFDFD
          FDFDFDFDFDFDFDFDFDFDFDFDFD830007EDB5F70707F50707080707B6EEB6F79D
          070083FDFDFDFDFDFDFDFDFDFDFDFDFD83ABF5F7AE070707EEADABABADF7ADB6
          070707F7F7AE9B83FDFDFDFDFDFDFDFDFDFDFD83ABEEAE07F508AB9B52405042
          504040939B930807B6EDF7AB83FDFDFDFDFDFDFDFDFD83ABF507F507EE525242
          5052425252405250405042AB0807EEADAB83FDFDFDFDFDFDFDC69AB607EEAEAB
          92404052908290909292825042525042DAF707F7F75AC6FDFDFDFDFDFD43F7F5
          B6089B40429092909292989A9290989092904250429209B6F79B82FDFDFDFDFD
          82F507B607AE4252909292989293929292929392909A92524250AD08B6F7F542
          FDFDFDFD00EFEEEEF5905298929892939A929293929A92929A929090520440F7
          07F5AD00FDFDFDC69A07F5F5F752929292929A9292939A929A93929892929398
          8252909B07EEF79386FDFD83F707B607429A929A929293929A92929392929292
          92929292925042400707B5AA83FDFD83ADF5EEED92929292929A92929292929A
          939A93929A939A9398825240F5B6ED9B83FDC69B0707EE5A9292939292929398
          909A92929292929292929292929042425207EDF55AC5C69B07B6F5539A9ADA9A
          939A92929292909890929893929B929A929052905207B6F712C6FDAB07EEF793
          93DB9A9292929392929A92939A929292929A929392930442920707F758C6C7AA
          07F5B59BDA9BDA929B92929A939292929293939A9292929292928250520707ED
          5AC6FDAB07AEF79BEBDBDB92929A9392929A93929A9A9292939A939A93925240
          5307F5B652C6C69B0807ED9BDBEBDB9A9392929A939292929392929292929292
          929A82409A07F5ED5AC6C7AB07EEAEABF7ABDBD2929A92939A929A929A92939A
          9298909A9292908292EF07F553C6FD95B507B59DDDF3EBD39292929292939293
          92929A9292909292909A92109D07B6F753C7FD85B507EEF7ABEEF7EB92939298
          9292989292939293929B929292929040EFF5EEAB83FDFD85AD07F5EDEDF7EDF7
          EA9292929893929B929A929A9292D29A929A049DB607F79D85FDFDFD5207B6ED
          ADEEB5EEEDAA9292929A92929292929393929A93929293B5EEF50840FDFDFDFD
          53090807F7F5ED08EDEDDB9A929293929A93929A9A9A9A9A929A9D07B607EF00
          FDFDFDFDFD9BB6F5EE9DF70907EDF5EBDB9B9A929A939ADBDBD3DA93929A0707
          B6EE50FDFDFDFDFDFDFDAB08F5B6F7F7F507090709EDDDF7DBEBEBEBDDAB939A
          93EEF5070753C6FDFDFDFDFDFDC795B507EDF79DF7B609EEF507F507EDEDEDF7
          F79B93ADEDEEB6EEAE53FDFDFDFDFDFDFDFDFD9D07B6F5B6F79B07F5F707EEB6
          EEF7EDAB9B9DF7F5AEF507F542FDFDFDFDFDFDFDFDFDFDFD9BF5080707F5AD9B
          F7DDABF7ABF7B5AEF7B5EE07EE07B582FDFDFDFDFDFDFDFDFDFDFDFDFD9DAD08
          B607EEF5EDADF79DAD9DEDAEF5EEB6F5EFAA93FDFDFDFDFDFDFDFDFDFDFDFDFD
          FDFDC79B070807B607F507EEF5B6B6F507B6F50792C7FDFDFDFDFDFDFDFDFDFD
          FDFDFDFDFDFDFDC79B95B5F507080708F5070707B5F74392FDFDFDFDFDFDFDFD
          FDFDFDFDFDFDFDFDFDFDFDFDFDFDC5C59BABB5ABABADB39B8593FDFDFDFDFDFD
          FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDC7FDFDC6C7D7FDC6FDFDFDFD
          FDFDFDFDFDFDFDFDFDFD}
        TransparentMode = tmPixel
        Transparent = True
      end
      object Label31: TLabel
        Left = 79
        Top = 113
        Width = 18
        Height = 13
        Caption = 'ON'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label33: TLabel
        Left = 71
        Top = 15
        Width = 25
        Height = 13
        Caption = 'OFF'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object VrBitmapButton5: TVrBitmapButton
        Left = 56
        Top = 36
        Width = 49
        Height = 42
        TransparentMode = tmPixel
        Transparent = True
      end
    end
    object GroupBox9: TGroupBox
      Left = 215
      Top = 687
      Width = 193
      Height = 376
      TabOrder = 20
      object Label46: TLabel
        Left = 61
        Top = 344
        Width = 58
        Height = 13
        Caption = 'DEGREES'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label47: TLabel
        Left = 45
        Top = 168
        Width = 111
        Height = 13
        Caption = 'TARGET BEARING'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object VrRotarySwitch24: TVrRotarySwitch
        Left = 21
        Top = 216
        Width = 153
        Height = 124
        Radius = 45
        SwitchPositions.Strings = (
          ' '
          ' '
          ' '
          ' '
          ' '
          ' '
          ' '
          ' '
          ' '
          ' '
          ' ')
        SwitchPosition = 1
        SwitchAngleStart = 100
        SwitchAngleEnd = 260
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
      end
      object VrRotarySwitch25: TVrRotarySwitch
        Left = 8
        Top = 16
        Width = 177
        Height = 148
        Radius = 60
        SwitchPositions.Strings = (
          '0'
          ' '
          ' '
          '30'
          ' '
          ' '
          '60'
          ' '
          ' '
          '90'
          ' '
          ' '
          '120'
          ' '
          ' '
          '150'
          ' '
          ' '
          '180'
          ' '
          ' '
          '210'
          ''
          ' '
          '240'
          ' '
          ' '
          '270'
          ' '
          ' '
          '300'
          ' '
          ' '
          '330'
          ' '
          ' ')
        SwitchAngleStart = 180
        SwitchAngleEnd = 540
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
      end
    end
    object GroupBox10: TGroupBox
      Left = 415
      Top = 687
      Width = 193
      Height = 376
      TabOrder = 21
      object VrBlinkLed31: TVrBlinkLed
        Left = 87
        Top = 21
        Width = 26
        Height = 27
        Palette1.Low = clBlack
        Palette1.High = clNavy
        Palette2.Low = clBlack
        Palette2.High = clAqua
        Palette3.Low = clBlack
        Palette3.High = clYellow
        Palette4.Low = clBlack
        Palette4.High = clLime
        Margin = 2
        Spacing = 3
        Color = clSkyBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        BlinkSpeed = 500
      end
      object VrBlinkLed32: TVrBlinkLed
        Left = 87
        Top = 269
        Width = 26
        Height = 27
        Palette1.Low = clBlack
        Palette1.High = clNavy
        Palette2.Low = clBlack
        Palette2.High = clAqua
        Palette3.Low = clBlack
        Palette3.High = clYellow
        Palette4.Low = clBlack
        Palette4.High = clLime
        Margin = 2
        Spacing = 3
        Color = clSkyBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        BlinkSpeed = 500
      end
      object Label48: TLabel
        Left = 56
        Top = 250
        Width = 97
        Height = 13
        Caption = 'TARGET RANGE'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label49: TLabel
        Left = 56
        Top = 50
        Width = 71
        Height = 13
        Caption = 'SET RANGE'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label50: TLabel
        Left = 45
        Top = 162
        Width = 108
        Height = 13
        Caption = 'NAUTICAL MILES'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object VrNum1: TVrNum
        Left = 32
        Top = 88
        Width = 129
        Height = 65
        Palette.Low = clGreen
        Palette.High = clLime
        Color = clBlack
        ParentColor = False
      end
    end
    object VrRotarySwitch22: TVrRotarySwitch
      Left = 133
      Top = 1076
      Width = 84
      Height = 88
      Radius = 30
      SwitchPositions.Strings = (
        ' '
        ' '
        ' '
        ' '
        ' '
        ' '
        ' ')
      SwitchPosition = 1
      SwitchAngleStart = 270
      SwitchAngleEnd = 90
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
    end
    object VrRotarySwitch23: TVrRotarySwitch
      Left = 632
      Top = 1076
      Width = 94
      Height = 88
      Radius = 30
      SwitchPositions.Strings = (
        ' '
        ' '
        ' '
        ' '
        ' '
        ' '
        ' '
        ' ')
      SwitchPosition = 1
      SwitchAngleStart = 270
      SwitchAngleEnd = 90
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
    end
  end
end
