object frmAssignMisille: TfrmAssignMisille
  Left = 448
  Top = 263
  Width = 684
  Height = 373
  Caption = 'Assign Missile'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 676
    Height = 346
    Align = alClient
    Color = clGray
    TabOrder = 0
    object lbl5: TLabel
      Left = 24
      Top = 232
      Width = 24
      Height = 16
      Caption = 'DOF'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl4: TLabel
      Left = 22
      Top = 183
      Width = 84
      Height = 16
      Caption = 'Model Missile'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl9: TLabel
      Left = 183
      Top = 182
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
    object lbl10: TLabel
      Left = 184
      Top = 231
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
    object Label1: TLabel
      Left = 344
      Top = 231
      Width = 60
      Height = 16
      Caption = 'ID Missile'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lvMissile: TListView
      Left = 16
      Top = 16
      Width = 649
      Height = 150
      Columns = <
        item
          Caption = 'Missile Name'
          Width = 125
        end
        item
          Caption = 'Missile ID'
          Width = 80
        end
        item
          Caption = 'Model Name'
          Width = 100
        end
        item
          Caption = 'Dof Name'
          Width = 150
        end
        item
          Caption = 'Pos H'
        end
        item
          Caption = 'Pos P'
        end
        item
          Caption = 'Has Laucher'
          Width = 80
        end>
      GridLines = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnClick = lvMissileClick
    end
    object btnCancel: TAdvSmoothButton
      Left = 552
      Top = 292
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
      Caption = 'Close'
      Color = clBlack
      ParentFont = False
      TabOrder = 1
      Version = '1.6.9.4'
      OnClick = btnCancelClick
    end
    object btnOk: TAdvSmoothButton
      Left = 22
      Top = 292
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
      TabOrder = 2
      Version = '1.6.9.4'
      OnClick = btnOkClick
    end
    object cbbModel: TComboBox
      Left = 22
      Top = 201
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
    end
    object cbbDOF: TComboBox
      Left = 22
      Top = 249
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 4
    end
    object edtPosHeading: TEdit
      Left = 182
      Top = 200
      Width = 145
      Height = 21
      TabOrder = 5
    end
    object edtPosPitch: TEdit
      Left = 181
      Top = 248
      Width = 145
      Height = 21
      TabOrder = 6
    end
    object cbHasLauncher: TCheckBox
      Left = 343
      Top = 200
      Width = 121
      Height = 17
      Caption = 'Has Launcher'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
    end
    object edtMissileID: TEdit
      Left = 341
      Top = 248
      Width = 145
      Height = 21
      TabOrder = 8
    end
    object btnRemove: TAdvSmoothButton
      Left = 142
      Top = 292
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
      Caption = 'Remove'
      Color = clBlack
      ParentFont = False
      TabOrder = 9
      Version = '1.6.9.4'
      OnClick = btnRemoveClick
    end
  end
end
