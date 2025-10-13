object frmAssignWeapon: TfrmAssignWeapon
  Left = 1716
  Top = 304
  Width = 722
  Height = 419
  Caption = 'Assign Weapon'
  Color = clGray
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlmain: TPanel
    Left = 0
    Top = 0
    Width = 706
    Height = 381
    Align = alClient
    Color = clGray
    ParentBackground = False
    TabOrder = 0
    object lbl2: TLabel
      Left = 24
      Top = 264
      Width = 117
      Height = 16
      Caption = 'Weapon Launcher'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl1: TLabel
      Left = 24
      Top = 69
      Width = 92
      Height = 16
      Caption = 'Weapon Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl3: TLabel
      Left = 24
      Top = 13
      Width = 88
      Height = 16
      Caption = 'Weapon Type'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl8: TLabel
      Left = 374
      Top = 242
      Width = 50
      Height = 16
      Caption = 'SWITCH'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl10: TLabel
      Left = 540
      Top = 190
      Width = 66
      Height = 16
      Caption = 'POS PITCH'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl9: TLabel
      Left = 375
      Top = 190
      Width = 85
      Height = 16
      Caption = 'POS HEADING'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl6: TLabel
      Left = 542
      Top = 135
      Width = 38
      Height = 16
      Caption = 'DOF II'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl5: TLabel
      Left = 376
      Top = 136
      Width = 33
      Height = 16
      Caption = 'DOF I'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl7: TLabel
      Left = 543
      Top = 87
      Width = 80
      Height = 16
      Caption = 'Model Spout'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl4: TLabel
      Left = 374
      Top = 87
      Width = 74
      Height = 16
      Caption = 'Model Body'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtWeaponLauncher: TEdit
      Left = 152
      Top = 261
      Width = 201
      Height = 21
      TabOrder = 0
    end
    object lvWeapon: TListView
      Left = 22
      Top = 88
      Width = 329
      Height = 159
      Columns = <
        item
          Caption = 'ID'
        end
        item
          Caption = 'Weapon Name'
          Width = 250
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      GridLines = True
      RowSelect = True
      ParentFont = False
      TabOrder = 3
      ViewStyle = vsReport
      OnClick = lvWeaponClick
    end
    object btnOk: TAdvSmoothButton
      Left = 22
      Top = 328
      Width = 115
      Height = 38
      Cursor = crHandPoint
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -13
      Appearance.Font.Name = 'Tahoma'
      Appearance.Font.Style = [fsBold]
      Status.Caption = '0'
      Status.Appearance.Fill.Color = clRed
      Status.Appearance.Fill.ColorMirror = clNone
      Status.Appearance.Fill.ColorMirrorTo = clNone
      Status.Appearance.Fill.GradientType = gtSolid
      Status.Appearance.Fill.BorderColor = clGray
      Status.Appearance.Fill.Rounding = 0
      Status.Appearance.Fill.ShadowOffset = 0
      Status.Appearance.Fill.Glow = gmNone
      Status.Appearance.Font.Charset = DEFAULT_CHARSET
      Status.Appearance.Font.Color = clWhite
      Status.Appearance.Font.Height = -11
      Status.Appearance.Font.Name = 'Tahoma'
      Status.Appearance.Font.Style = []
      BevelColor = clGray
      Caption = 'Add'
      Color = clBlack
      ParentFont = False
      TabOrder = 1
      Version = '1.6.9.4'
      OnClick = btnOkClick
    end
    object btnCancel: TAdvSmoothButton
      Left = 144
      Top = 328
      Width = 113
      Height = 38
      Cursor = crHandPoint
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -13
      Appearance.Font.Name = 'Tahoma'
      Appearance.Font.Style = [fsBold]
      Status.Caption = '0'
      Status.Appearance.Fill.Color = clRed
      Status.Appearance.Fill.ColorMirror = clNone
      Status.Appearance.Fill.ColorMirrorTo = clNone
      Status.Appearance.Fill.GradientType = gtSolid
      Status.Appearance.Fill.BorderColor = clGray
      Status.Appearance.Fill.Rounding = 0
      Status.Appearance.Fill.ShadowOffset = 0
      Status.Appearance.Fill.Glow = gmNone
      Status.Appearance.Font.Charset = DEFAULT_CHARSET
      Status.Appearance.Font.Color = clWhite
      Status.Appearance.Font.Height = -11
      Status.Appearance.Font.Name = 'Tahoma'
      Status.Appearance.Font.Style = []
      BevelColor = clGray
      Caption = 'Cancel'
      Color = clBlack
      ParentFont = False
      TabOrder = 2
      Version = '1.6.9.4'
      OnClick = btnCancelClick
    end
    object cbbWeaponType: TComboBox
      Left = 23
      Top = 33
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 4
      OnChange = cbbWeaponTypeChange
    end
    object cbbSwitch: TComboBox
      Left = 374
      Top = 261
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 5
    end
    object cb3DActor: TCheckBox
      Left = 541
      Top = 262
      Width = 97
      Height = 17
      Caption = 'Is 3D Actor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      OnClick = cb3DActorClick
    end
    object edtPosHeading: TEdit
      Left = 374
      Top = 208
      Width = 145
      Height = 21
      TabOrder = 7
    end
    object edtPosPitch: TEdit
      Left = 540
      Top = 208
      Width = 145
      Height = 21
      TabOrder = 8
    end
    object cbbDOF_I: TComboBox
      Left = 374
      Top = 153
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 9
    end
    object cbbDOF_II: TComboBox
      Left = 542
      Top = 153
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 10
    end
    object cbbModelBody: TComboBox
      Left = 374
      Top = 105
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 11
    end
    object cbbModelSpout: TComboBox
      Left = 542
      Top = 105
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 12
    end
  end
end
