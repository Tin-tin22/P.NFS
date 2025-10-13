inherited frmTDCKanan_Rencong: TfrmTDCKanan_Rencong
  Left = 847
  Top = 517
  BorderStyle = bsDialog
  Caption = 'TDC Kanan Rencong'
  ClientHeight = 363
  ClientWidth = 292
  Color = clMoneyGreen
  Font.Color = clWhite
  Font.Height = -11
  Font.Name = 'Fixedsys'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object spbIdentUnknownUdara: TSpeedButtonImage [0]
    Left = 12
    Top = 13
    Width = 57
    Height = 57
    AllowAllUp = True
    Caption = 'A'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = 28
    Font.Name = 'TDCIdent'
    Font.Style = []
    ParentFont = False
    OnClick = spbIdentUnknownUdaraClick
    ImageList = ilGreenBox
    SpringLoaded = True
  end
  object spbidentUdaraHostile: TSpeedButtonImage [1]
    Left = 82
    Top = 13
    Width = 57
    Height = 57
    AllowAllUp = True
    Caption = 'B'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = 28
    Font.Name = 'TDCIdent'
    Font.Style = []
    ParentFont = False
    OnClick = spbidentUdaraHostileClick
    ImageList = ilGreenBox
    SpringLoaded = True
  end
  object spbIdentAtasAirHostile: TSpeedButtonImage [2]
    Left = 152
    Top = 13
    Width = 57
    Height = 57
    AllowAllUp = True
    Caption = 'E'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = 28
    Font.Name = 'TDCIdent'
    Font.Style = []
    ParentFont = False
    OnClick = spbIdentAtasAirHostileClick
    ImageList = ilGreenBox
    SpringLoaded = True
  end
  object SpeedButtonImage4: TSpeedButtonImage [3]
    Left = 222
    Top = 13
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    ImageList = ilBlueBox
    SpringLoaded = True
  end
  object SpeedButtonImage5: TSpeedButtonImage [4]
    Left = 12
    Top = 101
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    ImageList = ilBlueBox
    SpringLoaded = True
  end
  object spbIdentUdaraFriendly: TSpeedButtonImage [5]
    Left = 82
    Top = 101
    Width = 57
    Height = 57
    AllowAllUp = True
    Caption = 'C'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = 28
    Font.Name = 'TDCIdent'
    Font.Style = []
    ParentFont = False
    OnClick = spbIdentUdaraFriendlyClick
    ImageList = ilGreenBox
    SpringLoaded = True
  end
  object spbIdentAtasAirFriendly: TSpeedButtonImage [6]
    Left = 152
    Top = 101
    Width = 57
    Height = 57
    AllowAllUp = True
    Caption = 'F '
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = 28
    Font.Name = 'TDCIdent'
    Font.Style = []
    ParentFont = False
    OnClick = spbIdentAtasAirFriendlyClick
    ImageList = ilGreenBox
    SpringLoaded = True
  end
  object SpeedButtonImage8: TSpeedButtonImage [7]
    Left = 222
    Top = 101
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    ImageList = ilBlueBox
    SpringLoaded = True
  end
  object SpeedButtonImage9: TSpeedButtonImage [8]
    Left = 12
    Top = 189
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    ImageList = ilBlueBox
    SpringLoaded = True
  end
  object SpeedButtonImage10: TSpeedButtonImage [9]
    Left = 82
    Top = 189
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    ImageList = ilBlueBox
    SpringLoaded = True
  end
  object SpeedButtonImage11: TSpeedButtonImage [10]
    Left = 152
    Top = 189
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    ImageList = ilBlueBox
    SpringLoaded = True
  end
  object SpeedButtonImage12: TSpeedButtonImage [11]
    Left = 222
    Top = 189
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    ImageList = ilBlueBox
    SpringLoaded = True
  end
  object spbNextTrack: TSpeedButtonImage [12]
    Left = 12
    Top = 269
    Width = 57
    Height = 57
    AllowAllUp = True
    Caption = 'NEXT'
    Flat = True
    OnClick = spbNextTrackClick
    ImageList = ilGreenBox
    SpringLoaded = True
  end
  object SpeedButtonImage14: TSpeedButtonImage [13]
    Left = 82
    Top = 269
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    ImageList = ilBlueBox
    SpringLoaded = True
  end
  object spbCorrect: TSpeedButtonImage [14]
    Left = 152
    Top = 269
    Width = 57
    Height = 57
    AllowAllUp = True
    Caption = 'CORR'
    Flat = True
    OnClick = spbCorrectClick
    ImageList = ilGreenBox
    SpringLoaded = True
  end
  object SpeedButtonImage16: TSpeedButtonImage [15]
    Left = 222
    Top = 269
    Width = 57
    Height = 57
    AllowAllUp = True
    Caption = 'WIPE'
    Flat = True
    OnClick = SpeedButtonImage16Click
    ImageList = ilGreenBox
    SpringLoaded = True
  end
  inherited ilGreenBox: TImageList
    Left = 42
  end
  inherited ilBlueBox: TImageList
    Left = 78
  end
end
