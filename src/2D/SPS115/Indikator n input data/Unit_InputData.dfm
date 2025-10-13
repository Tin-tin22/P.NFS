object Frm_InputData: TFrm_InputData
  Left = 0
  Top = 0
  Caption = 'Frm_InputData'
  ClientHeight = 519
  ClientWidth = 812
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lbl8: TLabel
    Left = 8
    Top = 16
    Width = 193
    Height = 35
    AutoSize = False
    Caption = 'Asumsi data Otomatis'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl13: TLabel
    Left = 320
    Top = 7
    Width = 149
    Height = 24
    Caption = 'Set Error System'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object grp1: TGroupBox
    Left = 24
    Top = 189
    Width = 137
    Height = 129
    TabOrder = 0
    object lbl12: TLabel
      Left = 17
      Top = 23
      Width = 33
      Height = 13
      Alignment = taRightJustify
      Caption = 'Source'
    end
    object lbl11: TLabel
      Left = 11
      Top = 46
      Width = 39
      Height = 13
      Alignment = taRightJustify
      Caption = 'Heading'
    end
    object lbl10: TLabel
      Left = 20
      Top = 68
      Width = 30
      Height = 13
      Alignment = taRightJustify
      Caption = 'Speed'
    end
    object edt_Speed: TEdit
      Left = 56
      Top = 63
      Width = 73
      Height = 23
      AutoSize = False
      Color = clAqua
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 0
    end
    object edt_Heading: TEdit
      Left = 56
      Top = 40
      Width = 73
      Height = 23
      AutoSize = False
      Color = clAqua
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 1
    end
    object pnl30: TPanel
      Left = 36
      Top = 0
      Width = 64
      Height = 17
      BevelOuter = bvNone
      Caption = 'SHIP DATA'
      Color = clActiveBorder
      ParentBackground = False
      TabOrder = 2
    end
    object btn_Set: TButton
      Left = 20
      Top = 92
      Width = 81
      Height = 25
      Caption = 'Set'
      TabOrder = 3
      OnClick = btn_SetClick
    end
    object cbb_Source: TComboBox
      Left = 56
      Top = 19
      Width = 73
      Height = 21
      Style = csDropDownList
      Color = clSkyBlue
      TabOrder = 4
      Items.Strings = (
        'NDS'
        'LCP')
    end
  end
  object grp2: TGroupBox
    Left = 616
    Top = 273
    Width = 178
    Height = 224
    TabOrder = 1
    object lbl3: TLabel
      Left = 19
      Top = 45
      Width = 31
      Height = 13
      Alignment = taRightJustify
      Caption = 'Torp 2'
    end
    object lbl2: TLabel
      Left = 19
      Top = 21
      Width = 31
      Height = 13
      Alignment = taRightJustify
      Caption = 'Torp 6'
    end
    object lbl1: TLabel
      Left = 19
      Top = 141
      Width = 31
      Height = 13
      Alignment = taRightJustify
      Caption = 'Torp 3'
    end
    object lbl4: TLabel
      Left = 19
      Top = 117
      Width = 31
      Height = 13
      Alignment = taRightJustify
      Caption = 'Torp 1'
    end
    object lbl5: TLabel
      Left = 19
      Top = 96
      Width = 31
      Height = 13
      Alignment = taRightJustify
      Caption = 'Torp 5'
    end
    object lbl6: TLabel
      Left = 19
      Top = 68
      Width = 31
      Height = 13
      Alignment = taRightJustify
      Caption = 'Torp 4'
    end
    object pnl1: TPanel
      Left = 12
      Top = -4
      Width = 101
      Height = 17
      BevelOuter = bvNone
      Caption = ' SET TORPEDO'
      Color = clActiveBorder
      ParentBackground = False
      TabOrder = 0
    end
    object btnSetBarrel: TButton
      Left = 56
      Top = 187
      Width = 81
      Height = 25
      Caption = 'Set'
      TabOrder = 1
      OnClick = btnSetBarrelClick
    end
    object cbb1: TComboBox
      Left = 56
      Top = 115
      Width = 88
      Height = 21
      Style = csDropDownList
      Color = clAqua
      ItemIndex = 0
      TabOrder = 2
      Text = 'OK'
      Items.Strings = (
        'OK'
        'EMPTY'
        'FAIL')
    end
    object cbb2: TComboBox
      Left = 56
      Top = 41
      Width = 88
      Height = 21
      Style = csDropDownList
      Color = clAqua
      ItemIndex = 0
      TabOrder = 3
      Text = 'OK'
      Items.Strings = (
        'OK'
        'EMPTY'
        'FAIL')
    end
    object cbb3: TComboBox
      Left = 56
      Top = 136
      Width = 88
      Height = 21
      Style = csDropDownList
      Color = clAqua
      ItemIndex = 0
      TabOrder = 4
      Text = 'OK'
      Items.Strings = (
        'OK'
        'EMPTY'
        'FAIL')
    end
    object cbb4: TComboBox
      Left = 56
      Top = 64
      Width = 88
      Height = 21
      Style = csDropDownList
      Color = clAqua
      ItemIndex = 0
      TabOrder = 5
      Text = 'OK'
      Items.Strings = (
        'OK'
        'EMPTY'
        'FAIL')
    end
    object cbb5: TComboBox
      Left = 56
      Top = 92
      Width = 88
      Height = 21
      Style = csDropDownList
      Color = clAqua
      ItemIndex = 0
      TabOrder = 6
      Text = 'OK'
      Items.Strings = (
        'OK'
        'EMPTY'
        'FAIL')
    end
    object cbb6: TComboBox
      Left = 56
      Top = 19
      Width = 88
      Height = 21
      Style = csDropDownList
      Color = clAqua
      ItemIndex = 0
      TabOrder = 7
      Text = 'OK'
      Items.Strings = (
        'OK'
        'EMPTY'
        'FAIL')
    end
  end
  object grp3: TGroupBox
    Left = 24
    Top = 78
    Width = 137
    Height = 96
    TabOrder = 2
    object cbb_link: TComboBox
      Left = 20
      Top = 23
      Width = 101
      Height = 21
      Style = csDropDownList
      Color = clAqua
      TabOrder = 0
      Items.Strings = (
        'OP'
        'INOP')
    end
    object pnl2: TPanel
      Left = 36
      Top = 0
      Width = 64
      Height = 17
      BevelOuter = bvNone
      Caption = 'LINK'
      Color = clActiveBorder
      ParentBackground = False
      TabOrder = 1
    end
    object btn_link: TButton
      Left = 28
      Top = 50
      Width = 81
      Height = 25
      Caption = 'Set'
      TabOrder = 2
      OnClick = btn_linkClick
    end
  end
  object grp4: TGroupBox
    Left = 248
    Top = 37
    Width = 192
    Height = 226
    TabOrder = 3
    object lbl21: TLabel
      Left = 18
      Top = 94
      Width = 33
      Height = 13
      AutoSize = False
      Caption = '45'#186
    end
    object lbl22: TLabel
      Left = 9
      Top = 144
      Width = 25
      Height = 13
      AutoSize = False
      Caption = 'TEMP'
    end
    object lbl23: TLabel
      Left = 16
      Top = 52
      Width = 25
      Height = 13
      AutoSize = False
      Caption = 'TIU'
    end
    object lbl7: TLabel
      Left = 48
      Top = 23
      Width = 25
      Height = 13
      AutoSize = False
      Caption = 'PORT'
    end
    object lbl9: TLabel
      Left = 115
      Top = 23
      Width = 25
      Height = 13
      AutoSize = False
      Caption = 'STBD'
    end
    object lbl14: TLabel
      Left = 40
      Top = 202
      Width = 86
      Height = 13
      Caption = ' Disp : 0-1 s/d 0-7'
    end
    object pnl3: TPanel
      Left = 3
      Top = 0
      Width = 166
      Height = 17
      BevelOuter = bvNone
      Caption = 'SET PORT n STBD Error System'
      Color = clActiveBorder
      ParentBackground = False
      TabOrder = 0
    end
    object btnErrSystem: TButton
      Left = 55
      Top = 171
      Width = 81
      Height = 25
      Caption = 'Set'
      TabOrder = 1
      OnClick = btnErrSystemClick
    end
    object edtPort45: TEdit
      Left = 47
      Top = 94
      Width = 30
      Height = 21
      TabOrder = 2
      Text = '45'
    end
    object edtSTBD45: TEdit
      Left = 115
      Top = 94
      Width = 30
      Height = 21
      TabOrder = 3
      Text = '45'
    end
    object edtTmpPort: TEdit
      Left = 47
      Top = 134
      Width = 30
      Height = 22
      AutoSize = False
      Color = clAqua
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 4
      Text = '40'
    end
    object edtTmpStbd: TEdit
      Left = 115
      Top = 134
      Width = 30
      Height = 22
      AutoSize = False
      Color = clAqua
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 5
      Text = '40'
    end
    object cbbCbbPortSet: TComboBox
      Left = 47
      Top = 49
      Width = 44
      Height = 21
      Style = csDropDownList
      Color = clAqua
      ItemIndex = 0
      TabOrder = 6
      Text = 'OP'
      Items.Strings = (
        'OP'
        '0-1'
        '0-3'
        '0-5')
    end
    object cbbSTBDSet: TComboBox
      Left = 111
      Top = 49
      Width = 44
      Height = 21
      Style = csDropDownList
      Color = clAqua
      ItemIndex = 0
      TabOrder = 7
      Text = 'OP'
      Items.Strings = (
        'OP'
        '0-2'
        '0-4'
        '0-6'
        '')
    end
  end
  object grp6: TGroupBox
    Left = 446
    Top = 37
    Width = 348
    Height = 230
    TabOrder = 4
    object lbl15: TLabel
      Left = 105
      Top = 190
      Width = 176
      Height = 13
      Caption = ' Disp : N-1, N-2, N-4, N-5, N-6, N-10'
    end
    object pnl5: TPanel
      Left = 84
      Top = 1
      Width = 101
      Height = 17
      BevelOuter = bvNone
      Caption = 'TORPEDO  GYRO'
      Color = clActiveBorder
      ParentBackground = False
      TabOrder = 0
    end
    object btnTpoGyro: TButton
      Left = 18
      Top = 190
      Width = 81
      Height = 25
      Caption = 'Set'
      TabOrder = 1
      OnClick = btnTpoGyroClick
    end
    object rb_n10: TRadioButton
      Tag = 10
      Left = 16
      Top = 144
      Width = 295
      Height = 17
      Caption = 'Short circuit between the 28 Vps and the 0 Vps (N-10)'
      TabOrder = 2
    end
    object rb_N6: TRadioButton
      Tag = 6
      Left = 16
      Top = 120
      Width = 200
      Height = 17
      Caption = 'No link with Stbd (N-6)'
      TabOrder = 3
    end
    object rb_N5: TRadioButton
      Tag = 5
      Left = 16
      Top = 96
      Width = 200
      Height = 17
      Caption = 'No link with TIU Port (N-5)'
      TabOrder = 4
    end
    object rb_N4: TRadioButton
      Tag = 4
      Left = 16
      Top = 72
      Width = 177
      Height = 17
      Caption = 'Too long gyro starting time (N-4)'
      TabOrder = 5
    end
    object rb_N2: TRadioButton
      Tag = 2
      Left = 16
      Top = 49
      Width = 201
      Height = 17
      Caption = 'Gyro Starting overload current (N-2)'
      TabOrder = 6
    end
    object rb_N1: TRadioButton
      Tag = 1
      Left = 16
      Top = 24
      Width = 249
      Height = 25
      Caption = 'Too Long gyro caging time (N-1)'
      TabOrder = 7
    end
    object rb_GyroNormal: TRadioButton
      Left = 16
      Top = 167
      Width = 121
      Height = 17
      Caption = 'Normal Condition'
      Checked = True
      TabOrder = 8
      TabStop = True
    end
  end
  object grp5: TGroupBox
    Left = 248
    Top = 269
    Width = 362
    Height = 228
    TabOrder = 5
    object lbl16: TLabel
      Left = 129
      Top = 191
      Width = 170
      Height = 13
      Caption = ' Disp : N-3, N-5, N-6, N-7, N-8, N-9'
    end
    object pnl4: TPanel
      Left = 60
      Top = 1
      Width = 173
      Height = 17
      BevelOuter = bvNone
      Caption = 'SET ERROR BARREL  SELECTED'
      Color = clActiveBorder
      ParentBackground = False
      TabOrder = 0
    end
    object btnBrlSlct: TButton
      Left = 16
      Top = 191
      Width = 81
      Height = 25
      Caption = 'Set'
      TabOrder = 1
      OnClick = btnBrlSlctClick
    end
    object rbN_3: TRadioButton
      Tag = 3
      Left = 16
      Top = 24
      Width = 249
      Height = 25
      Caption = 'Untimely starting of the Exercise Head (N-3)'
      TabOrder = 2
    end
    object rbN_5: TRadioButton
      Tag = 5
      Left = 16
      Top = 49
      Width = 343
      Height = 17
      Caption = 
        'Barrel with started and / or selected Torpedo no longer ready (N' +
        '-5)'
      TabOrder = 3
    end
    object rbN_6: TRadioButton
      Tag = 6
      Left = 16
      Top = 72
      Width = 305
      Height = 17
      Caption = 'Absenceof gyro Step Motor Reference (N-6)'
      TabOrder = 4
    end
    object rbN_7: TRadioButton
      Tag = 7
      Left = 16
      Top = 96
      Width = 313
      Height = 17
      Caption = 'Error of writing of the presetting data into the torpedo (N-7)'
      TabOrder = 5
    end
    object rbN_8: TRadioButton
      Tag = 9
      Left = 16
      Top = 119
      Width = 329
      Height = 17
      Caption = 'Exercise Head not started (N-8)'
      TabOrder = 8
    end
    object rbNormalBrlSelcted: TRadioButton
      Left = 16
      Top = 168
      Width = 121
      Height = 17
      Caption = 'Normal Condition'
      Checked = True
      TabOrder = 6
      TabStop = True
    end
    object rbN_9: TRadioButton
      Tag = 9
      Left = 16
      Top = 142
      Width = 329
      Height = 17
      Caption = 'Exercise did not leave the barrel afte the FIRE command (N-9)'
      TabOrder = 7
    end
  end
end
