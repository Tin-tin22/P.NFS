inherited frmTDC2Kanan: TfrmTDC2Kanan
  Left = 0
  Top = 487
  BorderStyle = bsDialog
  Caption = 'TDC 2 KANAN'
  ClientHeight = 455
  ClientWidth = 292
  Color = clMoneyGreen
  Font.Color = clWhite
  Font.Height = -11
  Font.Name = 'Fixedsys'
  Font.Style = []
  OldCreateOrder = True
  ExplicitWidth = 298
  ExplicitHeight = 480
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel [0]
    Left = 8
    Top = 345
    Width = 32
    Height = 15
    Caption = 'NEXT'
  end
  object SpeedButtonImage9: TSpeedButtonImage [1]
    Left = 7
    Top = 365
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    OnClick = SpeedButtonImage9Click
    ImageList = ilOrangeBox
  end
  object Label24: TLabel [2]
    Left = 81
    Top = 345
    Width = 56
    Height = 15
    Caption = 'CORRECT'
  end
  object spbCorrect: TSpeedButtonImage [3]
    Left = 79
    Top = 365
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    OnClick = spbCorrectClick
    ImageList = ilOrangeBox
  end
  object Label29: TLabel [4]
    Left = 16
    Top = 426
    Width = 40
    Height = 15
    Caption = 'TRACK'
  end
  object spbInitRAM: TSpeedButtonImage [5]
    Left = 8
    Top = 31
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    OnClick = spbInitRAMClick
    ImageList = ilOrangeBox
  end
  object Label10: TLabel [6]
    Left = 84
    Top = 11
    Width = 48
    Height = 15
    Caption = 'ASSIGN'
  end
  object spbAssignRAMTrack: TSpeedButtonImage [7]
    Left = 80
    Top = 31
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    OnClick = spbAssignRAMTrackClick
    ImageList = ilOrangeBox
  end
  object Label11: TLabel [8]
    Left = 97
    Top = 94
    Width = 24
    Height = 15
    Caption = 'RAM'
  end
  object Label2: TLabel [9]
    Left = 5
    Top = 12
    Width = 64
    Height = 15
    Caption = 'INITIATE'
  end
  object Label3: TLabel [10]
    Left = 25
    Top = 94
    Width = 24
    Height = 15
    Caption = 'RAM'
  end
  object spbInitESMFix: TSpeedButtonImage [11]
    Left = 8
    Top = 143
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    OnClick = spbInitESMFixClick
    ImageList = ilOrangeBox
  end
  object SpeedButtonImage2: TSpeedButtonImage [12]
    Left = 80
    Top = 143
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    ImageList = ilOrangeBox
  end
  object SpeedButtonImage3: TSpeedButtonImage [13]
    Left = 151
    Top = 143
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    ImageList = ilOrangeBox
  end
  object SpeedButtonImage4: TSpeedButtonImage [14]
    Left = 223
    Top = 143
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    OnClick = SpeedButtonImage4Click
    ImageList = ilOrangeBox
  end
  object Label16: TLabel [15]
    Left = 6
    Top = 127
    Width = 64
    Height = 15
    Caption = 'INITIATE'
  end
  object Label17: TLabel [16]
    Left = 8
    Top = 203
    Width = 56
    Height = 15
    Caption = 'ESM FIX'
  end
  object spbIdentMissile: TSpeedButtonImage [17]
    Left = 224
    Top = 254
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    OnClick = spbIdentMissileClick
    ImageList = ilOrangeBox
  end
  object Label21: TLabel [18]
    Left = 222
    Top = 318
    Width = 56
    Height = 15
    Caption = 'MISSILE'
  end
  object Label4: TLabel [19]
    Left = 152
    Top = 345
    Width = 40
    Height = 15
    Caption = 'CLOSE'
  end
  object spbCloseControl: TSpeedButtonImage [20]
    Left = 151
    Top = 365
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    OnClick = spbCloseControlClick
    ImageList = ilOrangeBox
  end
  object Label5: TLabel [21]
    Left = 237
    Top = 426
    Width = 32
    Height = 15
    Caption = 'WIPE'
  end
  object spbWipe: TSpeedButtonImage [22]
    Left = 223
    Top = 365
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    OnClick = spbWipeClick
    ImageList = ilOrangeBox
  end
  object Label7: TLabel [23]
    Left = 151
    Top = 426
    Width = 56
    Height = 15
    Caption = 'CONTROL'
  end
  object Label6: TLabel [24]
    Left = 227
    Top = 126
    Width = 48
    Height = 15
    Caption = 'CURSOR'
  end
  object Label8: TLabel [25]
    Left = 252
    Top = 208
    Width = 8
    Height = 15
    Caption = '-'
  end
  object GroupBox1: TGroupBox [26]
    Left = 144
    Top = 7
    Width = 145
    Height = 105
    BiDiMode = bdLeftToRight
    Caption = 'DATA LINK'
    ParentBiDiMode = False
    TabOrder = 0
    object spbDataLinkPlus: TSpeedButtonImage
      Left = 8
      Top = 24
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = spbDataLinkPlusClick
      ImageList = ilOrangeBox
    end
    object Label13: TLabel
      Left = 29
      Top = 82
      Width = 8
      Height = 15
      Caption = '+'
    end
    object Label15: TLabel
      Left = 104
      Top = 82
      Width = 8
      Height = 15
      Caption = '-'
    end
    object spbDataLinkMin: TSpeedButtonImage
      Left = 77
      Top = 24
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = spbDataLinkMinClick
      ImageList = ilOrangeBox
    end
  end
  object GroupBox2: TGroupBox [27]
    Left = 0
    Top = 228
    Width = 217
    Height = 110
    Caption = 'IDENTITY'
    TabOrder = 1
    object spbIdentFriendly: TSpeedButtonImage
      Left = 8
      Top = 26
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = spbIdentFriendlyClick
      ImageList = ilOrangeBox
    end
    object spbSetIdentHostile: TSpeedButtonImage
      Left = 80
      Top = 26
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = spbSetIdentHostileClick
      ImageList = ilOrangeBox
    end
    object Label14: TLabel
      Left = 81
      Top = 90
      Width = 56
      Height = 15
      Caption = 'HOSTILE'
    end
    object Label18: TLabel
      Left = 153
      Top = 90
      Width = 56
      Height = 15
      Caption = 'UNKNOWN'
    end
    object spbUdaraUnknown: TSpeedButtonImage
      Left = 152
      Top = 26
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = spbUdaraUnknownClick
      ImageList = ilOrangeBox
    end
    object Label25: TLabel
      Left = 7
      Top = 90
      Width = 64
      Height = 15
      Caption = 'FRIENDLY'
    end
  end
  inherited ilOrangeBox: TImageList
    Left = 28
    Top = 47
  end
end
