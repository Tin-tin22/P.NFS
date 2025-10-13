inherited frmTDC2Kiri: TfrmTDC2Kiri
  Left = 0
  Top = 469
  BorderStyle = bsDialog
  Caption = 'TDC 2 KIRI'
  ClientHeight = 456
  ClientWidth = 292
  Color = clMoneyGreen
  Font.Color = clWindow
  Font.Height = -13
  Font.Name = 'Fixedsys'
  Font.Style = []
  OldCreateOrder = True
  ExplicitWidth = 298
  ExplicitHeight = 481
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel [0]
    Left = 7
    Top = 349
    Width = 48
    Height = 15
    Caption = 'ASSIGN'
  end
  object spbAssignSSM: TSpeedButtonImage [1]
    Left = 7
    Top = 366
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    OnClick = spbAssignSSMClick
    ImageList = ilOrangeBox
  end
  object Label23: TLabel [2]
    Left = 93
    Top = 426
    Width = 24
    Height = 15
    Caption = 'SSM'
  end
  object Label24: TLabel [3]
    Left = 78
    Top = 349
    Width = 64
    Height = 15
    Caption = 'DEASSIGN'
  end
  object SpeedButtonImage10: TSpeedButtonImage [4]
    Left = 79
    Top = 366
    Width = 57
    Height = 57
    AllowAllUp = True
    Flat = True
    OnClick = SpeedButtonImage10Click
    ImageList = ilOrangeBox
  end
  object Label29: TLabel [5]
    Left = 21
    Top = 426
    Width = 24
    Height = 15
    Caption = 'SSM'
  end
  object GroupBox1: TGroupBox [6]
    Left = 0
    Top = 0
    Width = 289
    Height = 110
    Caption = 'FC1'
    TabOrder = 0
    object spbSet_FC1: TSpeedButtonImage
      Left = 7
      Top = 30
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = spbSet_FC1Click
      ImageList = ilOrangeBox
    end
    object spbBreak_FC1: TSpeedButtonImage
      Left = 79
      Top = 30
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = spbBreak_FC1Click
      ImageList = ilOrangeBox
    end
    object spbHoldFire_FC1: TSpeedButtonImage
      Left = 223
      Top = 30
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = spbHoldFire_FC1Click
      ImageList = ilOrangeBox
    end
    object spbOpenFire_FC1: TSpeedButtonImage
      Left = 151
      Top = 30
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = spbOpenFire_FC1Click
      ImageList = ilOrangeBox
    end
    object Label9: TLabel
      Left = 20
      Top = 14
      Width = 32
      Height = 15
      Caption = 'RATO'
    end
    object Label10: TLabel
      Left = 88
      Top = 13
      Width = 40
      Height = 15
      Caption = 'BREAK'
    end
    object Label11: TLabel
      Left = 88
      Top = 91
      Width = 40
      Height = 15
      Caption = 'TRACK'
    end
    object Label12: TLabel
      Left = 156
      Top = 13
      Width = 32
      Height = 15
      Caption = 'OPEN'
    end
    object Label13: TLabel
      Left = 160
      Top = 91
      Width = 32
      Height = 15
      Caption = 'FIRE'
    end
    object Label14: TLabel
      Left = 231
      Top = 13
      Width = 32
      Height = 15
      Caption = 'HOLD'
    end
    object Label15: TLabel
      Left = 235
      Top = 91
      Width = 32
      Height = 15
      Caption = 'FIRE'
    end
  end
  object GroupBox2: TGroupBox [7]
    Left = 0
    Top = 115
    Width = 289
    Height = 110
    Caption = 'FC2'
    TabOrder = 1
    object spbSet_FC2: TSpeedButtonImage
      Left = 7
      Top = 30
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = spbSet_FC2Click
      ImageList = ilOrangeBox
    end
    object spbBreak_FC2: TSpeedButtonImage
      Left = 79
      Top = 30
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = spbBreak_FC2Click
      ImageList = ilOrangeBox
    end
    object spbHoldFire_FC2: TSpeedButtonImage
      Left = 223
      Top = 30
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = spbHoldFire_FC2Click
      ImageList = ilOrangeBox
    end
    object spbOpenFire_FC2: TSpeedButtonImage
      Left = 151
      Top = 30
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = spbOpenFire_FC2Click
      ImageList = ilOrangeBox
    end
    object Label2: TLabel
      Left = 20
      Top = 13
      Width = 32
      Height = 15
      Caption = 'RSTO'
    end
    object Label3: TLabel
      Left = 88
      Top = 12
      Width = 40
      Height = 15
      Caption = 'BREAK'
    end
    object Label4: TLabel
      Left = 88
      Top = 89
      Width = 40
      Height = 15
      Caption = 'TRACK'
    end
    object Label5: TLabel
      Left = 156
      Top = 12
      Width = 32
      Height = 15
      Caption = 'OPEN'
    end
    object Label6: TLabel
      Left = 160
      Top = 89
      Width = 32
      Height = 15
      Caption = 'FIRE'
    end
    object Label7: TLabel
      Left = 231
      Top = 12
      Width = 32
      Height = 15
      Caption = 'HOLD'
    end
    object Label8: TLabel
      Left = 235
      Top = 89
      Width = 32
      Height = 15
      Caption = 'FIRE'
    end
  end
  object GroupBox3: TGroupBox [8]
    Left = 0
    Top = 227
    Width = 289
    Height = 110
    Caption = 'FC3'
    TabOrder = 2
    object spbSet_FC3: TSpeedButtonImage
      Left = 7
      Top = 27
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = spbSet_FC3Click
      ImageList = ilOrangeBox
    end
    object spbBreak_FC3: TSpeedButtonImage
      Left = 79
      Top = 27
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = spbBreak_FC3Click
      ImageList = ilOrangeBox
    end
    object spbHoldFire_FC3: TSpeedButtonImage
      Left = 223
      Top = 27
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = spbHoldFire_FC3Click
      ImageList = ilOrangeBox
    end
    object spbOpenFire_FC3: TSpeedButtonImage
      Left = 151
      Top = 27
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = spbOpenFire_FC3Click
      ImageList = ilOrangeBox
    end
    object Label16: TLabel
      Left = 20
      Top = 12
      Width = 32
      Height = 15
      Caption = 'RSTO'
    end
    object Label17: TLabel
      Left = 81
      Top = 11
      Width = 40
      Height = 15
      Caption = 'BREAK'
    end
    object Label18: TLabel
      Left = 83
      Top = 86
      Width = 40
      Height = 15
      Caption = 'TRACK'
    end
    object Label19: TLabel
      Left = 164
      Top = 12
      Width = 32
      Height = 15
      Caption = 'OPEN'
    end
    object Label20: TLabel
      Left = 163
      Top = 86
      Width = 32
      Height = 15
      Caption = 'FIRE'
    end
    object Label21: TLabel
      Left = 231
      Top = 12
      Width = 32
      Height = 15
      Caption = 'HOLD'
    end
    object Label22: TLabel
      Left = 238
      Top = 86
      Width = 32
      Height = 15
      Caption = 'FIRE'
    end
  end
  object GroupBox4: TGroupBox [9]
    Left = 144
    Top = 342
    Width = 145
    Height = 107
    Caption = 'FC4'
    TabOrder = 3
    object SpeedButtonImage11: TSpeedButtonImage
      Left = 79
      Top = 28
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = SpeedButtonImage11Click
      ImageList = ilOrangeBox
    end
    object SpeedButtonImage12: TSpeedButtonImage
      Left = 7
      Top = 28
      Width = 57
      Height = 57
      AllowAllUp = True
      Flat = True
      OnClick = SpeedButtonImage12Click
      ImageList = ilOrangeBox
    end
    object Label25: TLabel
      Left = 20
      Top = 11
      Width = 32
      Height = 15
      Caption = 'OPEN'
    end
    object Label26: TLabel
      Left = 21
      Top = 87
      Width = 32
      Height = 15
      Caption = 'FIRE'
    end
    object Label27: TLabel
      Left = 93
      Top = 11
      Width = 32
      Height = 15
      Caption = 'HOLD'
    end
    object Label28: TLabel
      Left = 96
      Top = 87
      Width = 32
      Height = 15
      Caption = 'FIRE'
    end
  end
  inherited ilOrangeBox: TImageList
    Left = 28
    Top = 47
  end
end
