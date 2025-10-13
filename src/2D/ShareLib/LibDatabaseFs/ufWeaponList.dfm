object frmWeaponList: TfrmWeaponList
  Left = 229
  Top = 220
  Width = 920
  Height = 428
  Caption = 'Weapon List'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 912
    Height = 401
    Align = alClient
    Color = clGray
    ParentBackground = False
    TabOrder = 0
    object lbl1: TLabel
      Left = 16
      Top = 16
      Width = 87
      Height = 19
      Caption = 'Ship Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtShipName: TEdit
      Left = 114
      Top = 16
      Width = 177
      Height = 21
      Color = clWhite
      Enabled = False
      TabOrder = 0
    end
    object btnClose: TAdvSmoothButton
      Left = 760
      Top = 346
      Width = 112
      Height = 39
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -13
      Appearance.Font.Name = 'Tahoma'
      Appearance.Font.Style = [fsBold]
      Status.Appearance.Fill.ColorMirror = clNone
      Status.Appearance.Fill.ColorMirrorTo = clNone
      Status.Appearance.Fill.BorderColor = clNone
      Status.Appearance.Fill.Rounding = 0
      Status.Appearance.Fill.ShadowOffset = 0
      Status.Appearance.Fill.Glow = gmNone
      Status.Appearance.Font.Charset = DEFAULT_CHARSET
      Status.Appearance.Font.Color = clWindowText
      Status.Appearance.Font.Height = -11
      Status.Appearance.Font.Name = 'Tahoma'
      Status.Appearance.Font.Style = []
      BevelColor = clGray
      Caption = 'Close'
      Color = clBlack
      ParentFont = False
      TabOrder = 1
      Version = '1.6.9.4'
      OnClick = btnCloseClick
    end
    object lvWeaponSelect: TListView
      Left = 16
      Top = 43
      Width = 505
      Height = 222
      Columns = <
        item
          Caption = 'ID'
        end
        item
          Caption = 'Weapon Name'
          Width = 200
        end
        item
          Caption = 'Launcher'
          Width = 150
        end
        item
          Caption = 'Number #'
          Width = 100
        end>
      GridLines = True
      RowSelect = True
      TabOrder = 2
      ViewStyle = vsReport
      OnClick = lvWeaponSelectClick
    end
    object btnAddweapon: TAdvSmoothButton
      Left = 16
      Top = 274
      Width = 129
      Height = 39
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -13
      Appearance.Font.Name = 'Tahoma'
      Appearance.Font.Style = [fsBold]
      Status.Appearance.Fill.ColorMirror = clNone
      Status.Appearance.Fill.ColorMirrorTo = clNone
      Status.Appearance.Fill.BorderColor = clNone
      Status.Appearance.Fill.Rounding = 0
      Status.Appearance.Fill.ShadowOffset = 0
      Status.Appearance.Fill.Glow = gmNone
      Status.Appearance.Font.Charset = DEFAULT_CHARSET
      Status.Appearance.Font.Color = clWindowText
      Status.Appearance.Font.Height = -11
      Status.Appearance.Font.Name = 'Tahoma'
      Status.Appearance.Font.Style = []
      BevelColor = clGray
      Caption = 'Add Weapon'
      Color = clBlack
      ParentFont = False
      TabOrder = 3
      Version = '1.6.9.4'
      OnClick = btnAddweaponClick
    end
    object btnRemove: TAdvSmoothButton
      Left = 408
      Top = 274
      Width = 113
      Height = 39
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = clWhite
      Appearance.Font.Height = -13
      Appearance.Font.Name = 'Tahoma'
      Appearance.Font.Style = [fsBold]
      Status.Appearance.Fill.ColorMirror = clNone
      Status.Appearance.Fill.ColorMirrorTo = clNone
      Status.Appearance.Fill.BorderColor = clNone
      Status.Appearance.Fill.Rounding = 0
      Status.Appearance.Fill.ShadowOffset = 0
      Status.Appearance.Fill.Glow = gmNone
      Status.Appearance.Font.Charset = DEFAULT_CHARSET
      Status.Appearance.Font.Color = clWindowText
      Status.Appearance.Font.Height = -11
      Status.Appearance.Font.Name = 'Tahoma'
      Status.Appearance.Font.Style = []
      BevelColor = clGray
      Caption = 'Remove'
      Color = clBlack
      ParentFont = False
      TabOrder = 4
      Version = '1.6.9.4'
      OnClick = btnRemoveClick
    end
    object btnAddMissile: TAdvSmoothButton
      Left = 152
      Top = 274
      Width = 145
      Height = 39
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
      Status.Appearance.Fill.BorderColor = clNone
      Status.Appearance.Fill.Rounding = 0
      Status.Appearance.Fill.ShadowOffset = 0
      Status.Appearance.Fill.Glow = gmNone
      Status.Appearance.Font.Charset = DEFAULT_CHARSET
      Status.Appearance.Font.Color = clWindowText
      Status.Appearance.Font.Height = -11
      Status.Appearance.Font.Name = 'Tahoma'
      Status.Appearance.Font.Style = []
      BevelColor = clGray
      Caption = 'Edit Missile'
      Color = clBlack
      ParentFont = False
      TabOrder = 5
      Version = '1.6.9.4'
      OnClick = btnAddMissileClick
    end
    object btnEditWeapon: TAdvSmoothButton
      Left = 16
      Top = 315
      Width = 129
      Height = 39
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
      Status.Appearance.Fill.BorderColor = clNone
      Status.Appearance.Fill.Rounding = 0
      Status.Appearance.Fill.ShadowOffset = 0
      Status.Appearance.Fill.Glow = gmNone
      Status.Appearance.Font.Charset = DEFAULT_CHARSET
      Status.Appearance.Font.Color = clWindowText
      Status.Appearance.Font.Height = -11
      Status.Appearance.Font.Name = 'Tahoma'
      Status.Appearance.Font.Style = []
      BevelColor = clGray
      Caption = 'Edit Weapon'
      Color = clBlack
      ParentFont = False
      TabOrder = 6
      Version = '1.6.9.4'
      OnClick = btnEditWeaponClick
    end
    object pnlShow: TPanel
      Left = 536
      Top = 40
      Width = 361
      Height = 273
      BevelOuter = bvNone
      Color = clGray
      TabOrder = 7
      object pnlDetail: TPanel
        Left = 0
        Top = 0
        Width = 361
        Height = 273
        Align = alClient
        BevelOuter = bvNone
        Color = clGray
        TabOrder = 0
        object lbl8: TLabel
          Left = 27
          Top = 169
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
        object lbl2: TLabel
          Left = 196
          Top = 169
          Width = 96
          Height = 16
          Caption = 'Using 3D Actor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbl10: TLabel
          Left = 26
          Top = 117
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
          Left = 196
          Top = 117
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
        object lbl5: TLabel
          Left = 24
          Top = 66
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
        object lbl6: TLabel
          Left = 194
          Top = 65
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
        object lbl7: TLabel
          Left = 193
          Top = 16
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
          Left = 25
          Top = 17
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
        object edtSwitch: TEdit
          Left = 25
          Top = 188
          Width = 145
          Height = 21
          Enabled = False
          TabOrder = 0
        end
        object edt3DActor: TEdit
          Left = 193
          Top = 187
          Width = 145
          Height = 21
          Enabled = False
          TabOrder = 1
        end
        object edtPosHeading: TEdit
          Left = 192
          Top = 134
          Width = 145
          Height = 21
          Enabled = False
          TabOrder = 2
        end
        object edtPosPitch: TEdit
          Left = 24
          Top = 135
          Width = 145
          Height = 21
          Enabled = False
          TabOrder = 3
        end
        object edtDOF1: TEdit
          Left = 24
          Top = 83
          Width = 145
          Height = 21
          Enabled = False
          TabOrder = 4
        end
        object edtDOF2: TEdit
          Left = 192
          Top = 84
          Width = 145
          Height = 21
          Enabled = False
          TabOrder = 5
        end
        object edtModelSpout: TEdit
          Left = 192
          Top = 35
          Width = 145
          Height = 21
          Enabled = False
          TabOrder = 6
        end
        object edtModelBody: TEdit
          Left = 24
          Top = 35
          Width = 145
          Height = 21
          Enabled = False
          TabOrder = 7
        end
      end
      object pnlEdit: TPanel
        Left = 0
        Top = 0
        Width = 361
        Height = 273
        Align = alClient
        BevelOuter = bvNone
        Color = clGray
        TabOrder = 1
        object Label2: TLabel
          Left = 24
          Top = 165
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
        object Label3: TLabel
          Left = 24
          Top = 113
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
        object Label4: TLabel
          Left = 196
          Top = 113
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
        object Label5: TLabel
          Left = 194
          Top = 61
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
        object Label6: TLabel
          Left = 24
          Top = 62
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
        object Label7: TLabel
          Left = 25
          Top = 13
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
        object Label8: TLabel
          Left = 193
          Top = 12
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
        object lbl3: TLabel
          Left = 24
          Top = 213
          Width = 78
          Height = 16
          Caption = 'Launcher ID'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtUpdatePitch: TEdit
          Left = 23
          Top = 131
          Width = 145
          Height = 21
          TabOrder = 0
        end
        object edtUpdateHeading: TEdit
          Left = 192
          Top = 130
          Width = 145
          Height = 21
          TabOrder = 1
        end
        object btnUpdate: TAdvSmoothButton
          Left = 209
          Top = 224
          Width = 125
          Height = 36
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
          Status.Appearance.Fill.BorderColor = clNone
          Status.Appearance.Fill.Rounding = 0
          Status.Appearance.Fill.ShadowOffset = 0
          Status.Appearance.Fill.Glow = gmNone
          Status.Appearance.Font.Charset = DEFAULT_CHARSET
          Status.Appearance.Font.Color = clWindowText
          Status.Appearance.Font.Height = -11
          Status.Appearance.Font.Name = 'Tahoma'
          Status.Appearance.Font.Style = []
          BevelColor = clGray
          Caption = 'Update Weapon'
          Color = clBlack
          ParentFont = False
          TabOrder = 2
          Version = '1.6.9.4'
          OnClick = btnUpdateClick
        end
        object cbbModelBody: TComboBox
          Left = 22
          Top = 33
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 3
        end
        object cbbModelSpout: TComboBox
          Left = 193
          Top = 33
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 4
        end
        object cbbDOF_I: TComboBox
          Left = 22
          Top = 80
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 5
        end
        object cbbDOF_II: TComboBox
          Left = 193
          Top = 80
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 6
        end
        object cbbSwitch: TComboBox
          Left = 23
          Top = 182
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 7
        end
        object cb3DActor: TCheckBox
          Left = 194
          Top = 183
          Width = 97
          Height = 17
          Caption = 'Is 3D Actor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 8
          OnClick = cb3DActorClick
        end
        object edtLauncher: TEdit
          Left = 23
          Top = 231
          Width = 145
          Height = 21
          TabOrder = 9
        end
      end
    end
  end
end
