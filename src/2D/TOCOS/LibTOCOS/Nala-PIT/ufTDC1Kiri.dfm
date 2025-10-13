inherited frmTDC1Kiri: TfrmTDC1Kiri
  Left = 0
  Top = 5
  BorderStyle = bsDialog
  Caption = 'TDC1 KIRI'
  ClientHeight = 441
  ClientWidth = 292
  Color = clMoneyGreen
  DefaultMonitor = dmPrimary
  Font.Color = clWhite
  Font.Height = -11
  Font.Name = 'Fixedsys'
  Font.Style = []
  OldCreateOrder = True
  ExplicitWidth = 298
  ExplicitHeight = 466
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel [0]
    Left = 14
    Top = 334
    Width = 48
    Height = 15
    Caption = 'ASSIGN'
  end
  object spbAssignASRL: TSpeedButtonImage [1]
    Left = 10
    Top = 352
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    OnClick = spbAssignASRLClick
    ImageList = ilOrangeBox
  end
  object Label24: TLabel [2]
    Left = 79
    Top = 334
    Width = 64
    Height = 15
    Caption = 'DEASSIGN'
  end
  object spbDeAssignASRL: TSpeedButtonImage [3]
    Left = 83
    Top = 352
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    OnClick = spbDeAssignASRLClick
    ImageList = ilOrangeBox
  end
  object Label29: TLabel [4]
    Left = 21
    Top = 411
    Width = 32
    Height = 15
    Caption = 'ASRL'
  end
  object spbSetInitDatum: TSpeedButtonImage [5]
    Left = 10
    Top = 27
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    Spacing = 1
    OnClick = spbSetInitDatumClick
    ImageList = ilOrangeBox
  end
  object Label2: TLabel [6]
    Left = 5
    Top = 9
    Width = 64
    Height = 15
    Caption = 'INITIATE'
  end
  object SpeedButtonImage4: TSpeedButtonImage [7]
    Left = 223
    Top = 135
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    ImageList = ilOrangeBox
  end
  object spbIdentNonSubmarine: TSpeedButtonImage [8]
    Left = 223
    Top = 239
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    OnClick = spbIdentNonSubmarineClick
    ImageList = ilOrangeBox
  end
  object Label21: TLabel [9]
    Left = 237
    Top = 300
    Width = 24
    Height = 15
    Caption = 'SUB'
  end
  object SpeedButtonImage11: TSpeedButtonImage [10]
    Left = 153
    Top = 352
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    ImageList = ilOrangeBox
  end
  object Label5: TLabel [11]
    Left = 232
    Top = 412
    Width = 32
    Height = 15
    Caption = 'WIPE'
  end
  object spbWipeLeft: TSpeedButtonImage [12]
    Left = 223
    Top = 352
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    OnClick = spbWipeLeftClick
    ImageList = ilOrangeBox
  end
  object Label11: TLabel [13]
    Left = 17
    Top = 87
    Width = 40
    Height = 15
    Caption = 'DATUM'
  end
  object SpeedButtonImage13: TSpeedButtonImage [14]
    Left = 154
    Top = 135
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    ImageList = ilOrangeBox
  end
  object Label6: TLabel [15]
    Left = 239
    Top = 217
    Width = 24
    Height = 15
    Caption = 'NON'
  end
  object Label4: TLabel [16]
    Left = 94
    Top = 412
    Width = 32
    Height = 15
    Caption = 'ASRL'
  end
  object GroupBox1: TGroupBox [17]
    Left = 76
    Top = 7
    Width = 208
    Height = 99
    BiDiMode = bdLeftToRight
    Caption = 'TORPEDO'
    ParentBiDiMode = False
    TabOrder = 0
    object spbSetAssignTorpedoMk44: TSpeedButtonImage
      Left = 11
      Top = 20
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = spbSetAssignTorpedoMk44Click
      ImageList = ilOrangeBox
    end
    object Label13: TLabel
      Left = 19
      Top = 77
      Width = 40
      Height = 15
      Caption = 'MK 44'
    end
    object Label15: TLabel
      Left = 86
      Top = 77
      Width = 40
      Height = 15
      Caption = 'A 244'
    end
    object spbAssignTorpedoA244: TSpeedButtonImage
      Left = 79
      Top = 20
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = spbAssignTorpedoA244Click
      ImageList = ilOrangeBox
    end
    object spbSetDeAssignTorpedo: TSpeedButtonImage
      Left = 145
      Top = 20
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = spbSetDeAssignTorpedoClick
      ImageList = ilOrangeBox
    end
    object Label10: TLabel
      Left = 169
      Top = 77
      Width = 8
      Height = 15
      Caption = '-'
    end
  end
  object GroupBox2: TGroupBox [18]
    Left = 5
    Top = 215
    Width = 214
    Height = 108
    Caption = 'IDENTITY'
    TabOrder = 1
    object spbIdentFriendly: TSpeedButtonImage
      Left = 8
      Top = 23
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = spbIdentFriendlyClick
      ImageList = ilOrangeBox
    end
    object spbIdentHostile: TSpeedButtonImage
      Left = 80
      Top = 23
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = spbIdentHostileClick
      ImageList = ilOrangeBox
    end
    object Label14: TLabel
      Left = 80
      Top = 85
      Width = 56
      Height = 15
      Caption = 'HOSTILE'
    end
    object Label18: TLabel
      Left = 146
      Top = 85
      Width = 56
      Height = 15
      Caption = 'UNKNOWN'
    end
    object spbIdentUnknown: TSpeedButtonImage
      Left = 150
      Top = 23
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = spbIdentUnknownClick
      ImageList = ilOrangeBox
    end
    object Label25: TLabel
      Left = 6
      Top = 85
      Width = 64
      Height = 15
      Caption = 'FRIENDLY'
    end
  end
  object GroupBox3: TGroupBox [19]
    Left = 5
    Top = 111
    Width = 145
    Height = 103
    Caption = 'FOC'
    TabOrder = 2
    object spbFOCPlus: TSpeedButtonImage
      Left = 5
      Top = 23
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = spbFOCPlusClick
      ImageList = ilOrangeBox
    end
    object spbFOCMinus: TSpeedButtonImage
      Left = 81
      Top = 23
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = spbFOCMinusClick
      ImageList = ilOrangeBox
    end
    object Label8: TLabel
      Left = 29
      Top = 81
      Width = 8
      Height = 20
      Caption = '+'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial Narrow'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 93
      Top = 81
      Width = 4
      Height = 20
      Caption = '-'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial Narrow'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  inherited ilOrangeBox: TImageList
    Left = 28
    Top = 47
  end
  inherited ilGreenBox: TImageList
    Left = 66
    Top = 48
  end
  inherited ilBlueBox: TImageList
    Left = 102
    Top = 48
  end
end
