inherited frmTDC1Kanan: TfrmTDC1Kanan
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'TDC1 KANAN'
  ClientHeight = 442
  ClientWidth = 308
  Color = clMoneyGreen
  Font.Color = clWhite
  Font.Height = -11
  Font.Name = 'Fixedsys'
  Font.Style = []
  OldCreateOrder = True
  ExplicitWidth = 314
  ExplicitHeight = 467
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel [0]
    Left = 12
    Top = 338
    Width = 32
    Height = 15
    Caption = 'NEXT'
  end
  object spbNextTrack: TSpeedButtonImage [1]
    Left = 3
    Top = 357
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    OnClick = spbNextTrackClick
    ImageList = ilOrangeBox
  end
  object Label24: TLabel [2]
    Left = 85
    Top = 338
    Width = 56
    Height = 15
    Caption = 'CORRECT'
  end
  object spbCorrect: TSpeedButtonImage [3]
    Left = 83
    Top = 357
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    OnClick = spbCorrectClick
    ImageList = ilOrangeBox
  end
  object Label29: TLabel [4]
    Left = 13
    Top = 418
    Width = 40
    Height = 15
    Caption = 'TRACK'
  end
  object spbInitiateRAM: TSpeedButtonImage [5]
    Left = 12
    Top = 31
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    OnClick = spbInitiateRAMClick
    ImageList = ilOrangeBox
  end
  object Label10: TLabel [6]
    Left = 89
    Top = 14
    Width = 48
    Height = 15
    Caption = 'ASSIGN'
  end
  object spbAssignRAM: TSpeedButtonImage [7]
    Left = 84
    Top = 31
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    OnClick = spbAssignRAMClick
    ImageList = ilOrangeBox
  end
  object Label2: TLabel [8]
    Left = 7
    Top = 13
    Width = 64
    Height = 15
    Caption = 'INITIATE'
  end
  object spbCursorMin: TSpeedButtonImage [9]
    Left = 227
    Top = 135
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    OnClick = spbCursorMinClick
    ImageList = ilOrangeBox
  end
  object Label17: TLabel [10]
    Left = 227
    Top = 118
    Width = 48
    Height = 15
    Caption = 'CURSOR'
  end
  object spbIdentHelicopter: TSpeedButtonImage [11]
    Left = 228
    Top = 247
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    OnClick = spbIdentHelicopterClick
    ImageList = ilOrangeBox
  end
  object Label21: TLabel [12]
    Left = 229
    Top = 308
    Width = 56
    Height = 30
    Caption = 'HELI'#13#19'COPTER'
  end
  object Label4: TLabel [13]
    Left = 164
    Top = 338
    Width = 40
    Height = 15
    Caption = 'CLOSE'
  end
  object spbCloseControl: TSpeedButtonImage [14]
    Left = 155
    Top = 357
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    OnClick = spbCloseControlClick
    ImageList = ilOrangeBox
  end
  object Label5: TLabel [15]
    Left = 237
    Top = 414
    Width = 32
    Height = 15
    Caption = 'WIPE'
  end
  object spbWipe: TSpeedButtonImage [16]
    Left = 227
    Top = 357
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    OnClick = spbWipeClick
    ImageList = ilOrangeBox
  end
  object Label7: TLabel [17]
    Left = 156
    Top = 414
    Width = 56
    Height = 15
    Caption = 'CONTROL'
  end
  object Label6: TLabel [18]
    Left = 252
    Top = 200
    Width = 8
    Height = 15
    Caption = '-'
  end
  object Label11: TLabel [19]
    Left = 18
    Top = 89
    Width = 40
    Height = 15
    Caption = 'R A M'
  end
  object Label12: TLabel [20]
    Left = 90
    Top = 89
    Width = 40
    Height = 15
    Caption = 'R A M'
  end
  object GroupBox1: TGroupBox [21]
    Left = 148
    Top = 7
    Width = 141
    Height = 99
    BiDiMode = bdLeftToRight
    Caption = 'DATA LINK'
    ParentBiDiMode = False
    TabOrder = 0
    object SpeedButtonImage20: TSpeedButtonImage
      Left = 8
      Top = 24
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      ImageList = ilOrangeBox
    end
    object Label13: TLabel
      Left = 29
      Top = 81
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
    object SpeedButtonImage19: TSpeedButtonImage
      Left = 77
      Top = 24
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      ImageList = ilOrangeBox
    end
  end
  object GroupBox2: TGroupBox [22]
    Left = 4
    Top = 223
    Width = 221
    Height = 106
    Caption = 'IDENTITY'
    TabOrder = 1
    object spbIdentFriendly: TSpeedButtonImage
      Left = 8
      Top = 24
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = spbIdentFriendlyClick
      ImageList = ilOrangeBox
    end
    object spbIdentHostile: TSpeedButtonImage
      Left = 80
      Top = 24
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = spbIdentHostileClick
      ImageList = ilOrangeBox
    end
    object Label14: TLabel
      Left = 82
      Top = 85
      Width = 56
      Height = 15
      Caption = 'HOSTILE'
    end
    object Label18: TLabel
      Left = 152
      Top = 85
      Width = 56
      Height = 15
      Caption = 'UNKNOWN'
    end
    object spbIdentUnknown: TSpeedButtonImage
      Left = 152
      Top = 24
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = spbIdentUnknownClick
      ImageList = ilOrangeBox
    end
    object Label25: TLabel
      Left = 7
      Top = 85
      Width = 64
      Height = 15
      Caption = 'FRIENDLY'
    end
  end
  object GroupBox3: TGroupBox [23]
    Left = 5
    Top = 111
    Width = 212
    Height = 106
    Caption = 'PLOT'
    TabOrder = 2
    object SpeedButtonImage1: TSpeedButtonImage
      Left = 7
      Top = 23
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      ImageList = ilOrangeBox
    end
    object SpeedButtonImage2: TSpeedButtonImage
      Left = 79
      Top = 23
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      ImageList = ilOrangeBox
    end
    object SpeedButtonImage3: TSpeedButtonImage
      Left = 150
      Top = 23
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      ImageList = ilOrangeBox
    end
    object Label3: TLabel
      Left = 166
      Top = 83
      Width = 24
      Height = 15
      Caption = 'ICM'
    end
    object Label8: TLabel
      Left = 28
      Top = 80
      Width = 8
      Height = 15
      Caption = '+'
    end
    object Label9: TLabel
      Left = 103
      Top = 80
      Width = 8
      Height = 15
      Caption = '-'
    end
  end
  inherited ilOrangeBox: TImageList
    Left = 28
    Top = 47
  end
end
