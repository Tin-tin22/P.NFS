object FrmKoreksi: TFrmKoreksi
  Left = -1233
  Top = 39
  Caption = 'FrmKoreksi'
  ClientHeight = 627
  ClientWidth = 962
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 296
    Width = 409
    Height = 313
    Caption = 'Perhitungan di Server 2D'
    PopupMenu = PopupMenu1
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 64
      Width = 68
      Height = 13
      Caption = 'Elevasi (WCC)'
    end
    object Label3: TLabel
      Left = 18
      Top = 89
      Width = 73
      Height = 13
      Caption = 'Muzzle Velocity'
    end
    object Label4: TLabel
      Left = 18
      Top = 111
      Width = 94
      Height = 13
      Caption = 'Barometric Pressure'
    end
    object Label5: TLabel
      Left = 18
      Top = 143
      Width = 75
      Height = 13
      Caption = 'Air Temperature'
    end
    object Label6: TLabel
      Left = 18
      Top = 167
      Width = 40
      Height = 13
      Caption = 'Humidity'
    end
    object Label7: TLabel
      Left = 18
      Top = 191
      Width = 72
      Height = 13
      Caption = 'Following Wind'
    end
    object Label8: TLabel
      Left = 18
      Top = 247
      Width = 65
      Height = 13
      Caption = 'Target Speed'
    end
    object Label9: TLabel
      Left = 18
      Top = 223
      Width = 55
      Height = 13
      Caption = 'Ship Speed'
    end
    object Label11: TLabel
      Left = 176
      Top = 168
      Width = 8
      Height = 13
      Caption = '%'
    end
    object Label10: TLabel
      Left = 210
      Top = 61
      Width = 60
      Height = 13
      Caption = 'Jarak Target'
    end
    object Edit1: TEdit
      Left = 120
      Top = 60
      Width = 81
      Height = 21
      TabOrder = 0
    end
    object Edit2: TEdit
      Left = 120
      Top = 84
      Width = 81
      Height = 21
      Enabled = False
      TabOrder = 1
    end
    object Edit3: TEdit
      Left = 120
      Top = 109
      Width = 81
      Height = 21
      Enabled = False
      TabOrder = 2
    end
    object Edit4: TEdit
      Left = 120
      Top = 140
      Width = 81
      Height = 21
      Enabled = False
      TabOrder = 3
    end
    object Edit5: TEdit
      Left = 119
      Top = 164
      Width = 42
      Height = 21
      Enabled = False
      TabOrder = 4
    end
    object Edit6: TEdit
      Left = 119
      Top = 188
      Width = 82
      Height = 21
      Enabled = False
      TabOrder = 5
    end
    object Edit7: TEdit
      Left = 120
      Top = 216
      Width = 81
      Height = 21
      Enabled = False
      TabOrder = 6
    end
    object Edit8: TEdit
      Left = 120
      Top = 240
      Width = 81
      Height = 21
      Enabled = False
      TabOrder = 7
    end
    object btnRead: TButton
      Left = 64
      Top = 24
      Width = 89
      Height = 25
      Caption = 'Data'
      TabOrder = 8
      OnClick = btnReadClick
    end
    object btnCorrect: TButton
      Left = 240
      Top = 24
      Width = 81
      Height = 33
      Caption = 'Hitung'
      TabOrder = 9
      OnClick = btnCorrectClick
    end
    object txtDir: TEdit
      Left = 272
      Top = 60
      Width = 113
      Height = 21
      Enabled = False
      TabOrder = 10
    end
    object Memo1: TMemo
      Left = 256
      Top = 136
      Width = 105
      Height = 89
      Lines.Strings = (
        'Memo1')
      TabOrder = 11
    end
    object Button1: TButton
      Left = 296
      Top = 272
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 12
      OnClick = Button1Click
    end
    object Edit10: TEdit
      Left = 256
      Top = 248
      Width = 81
      Height = 21
      TabOrder = 13
      Text = '9000'
    end
    object Button2: TButton
      Left = 184
      Top = 272
      Width = 73
      Height = 25
      Caption = 'Button2'
      TabOrder = 14
      OnClick = Button2Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 16
    Width = 409
    Height = 249
    Caption = 'Perhitungan di WCC'
    TabOrder = 1
    object Label12: TLabel
      Left = 16
      Top = 32
      Width = 76
      Height = 13
      Caption = 'Target Distance'
    end
    object Label13: TLabel
      Left = 19
      Top = 57
      Width = 73
      Height = 13
      Caption = 'Muzzle Velocity'
    end
    object Label14: TLabel
      Left = 18
      Top = 81
      Width = 94
      Height = 13
      Caption = 'Barometric Pressure'
    end
    object Label15: TLabel
      Left = 18
      Top = 106
      Width = 75
      Height = 13
      Caption = 'Air Temperature'
    end
    object Label16: TLabel
      Left = 18
      Top = 131
      Width = 40
      Height = 13
      Caption = 'Humidity'
    end
    object Label17: TLabel
      Left = 18
      Top = 153
      Width = 72
      Height = 13
      Caption = 'Following Wind'
    end
    object Label18: TLabel
      Left = 20
      Top = 198
      Width = 65
      Height = 13
      Caption = 'Target Speed'
    end
    object Label19: TLabel
      Left = 18
      Top = 175
      Width = 55
      Height = 13
      Caption = 'Ship Speed'
    end
    object Label20: TLabel
      Left = 232
      Top = 128
      Width = 8
      Height = 13
      Caption = '%'
    end
    object Label21: TLabel
      Left = 230
      Top = 32
      Width = 8
      Height = 13
      Caption = 'm'
    end
    object Label22: TLabel
      Left = 228
      Top = 55
      Width = 18
      Height = 13
      Caption = 'm/s'
    end
    object Label23: TLabel
      Left = 228
      Top = 79
      Width = 14
      Height = 13
      Caption = 'mb'
    end
    object Label24: TLabel
      Left = 230
      Top = 103
      Width = 33
      Height = 13
      Caption = 'celcius'
    end
    object Label25: TLabel
      Left = 232
      Top = 150
      Width = 18
      Height = 13
      Caption = 'm/s'
    end
    object Label26: TLabel
      Left = 233
      Top = 173
      Width = 18
      Height = 13
      Caption = 'm/s'
    end
    object Label27: TLabel
      Left = 234
      Top = 197
      Width = 18
      Height = 13
      Caption = 'm/s'
    end
    object Label28: TLabel
      Left = 261
      Top = 56
      Width = 34
      Height = 13
      Caption = 'Elevasi'
    end
    object tdWCC: TEdit
      Left = 137
      Top = 28
      Width = 81
      Height = 21
      TabOrder = 0
      Text = '9125'
    end
    object mvWCC: TEdit
      Left = 138
      Top = 52
      Width = 81
      Height = 21
      TabOrder = 1
      Text = '1027'
    end
    object bpWCC: TEdit
      Left = 138
      Top = 76
      Width = 81
      Height = 21
      TabOrder = 2
      Text = '1005'
    end
    object atWCC: TEdit
      Left = 139
      Top = 99
      Width = 81
      Height = 21
      TabOrder = 3
      Text = '10'
    end
    object humWCC: TEdit
      Left = 139
      Top = 123
      Width = 42
      Height = 21
      TabOrder = 4
      Text = '60'
    end
    object fwWCC: TEdit
      Left = 139
      Top = 147
      Width = 82
      Height = 21
      TabOrder = 5
      Text = '8'
    end
    object ssWCC: TEdit
      Left = 139
      Top = 171
      Width = 81
      Height = 21
      TabOrder = 6
      Text = '15'
    end
    object tsWCC: TEdit
      Left = 140
      Top = 195
      Width = 81
      Height = 21
      TabOrder = 7
      Text = '5'
    end
    object btnCorrectClient: TButton
      Left = 288
      Top = 16
      Width = 81
      Height = 33
      Caption = 'Koreksi'
      TabOrder = 8
      OnClick = btnCorrectClientClick
    end
    object txtElevClient: TEdit
      Left = 304
      Top = 52
      Width = 65
      Height = 21
      TabOrder = 9
    end
    object Edit9: TEdit
      Left = 296
      Top = 152
      Width = 73
      Height = 21
      TabOrder = 10
      Text = 'Edit9'
    end
  end
  object Memo2: TMemo
    Left = 432
    Top = 24
    Width = 257
    Height = 585
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'Memo2')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object Memo3: TMemo
    Left = 696
    Top = 24
    Width = 257
    Height = 585
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'Memo2')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object PopupMenu1: TPopupMenu
    Left = 488
    Top = 272
    object pmConnect: TMenuItem
      Caption = 'Connect'
      OnClick = pmConnectClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object pmLog: TMenuItem
      Caption = 'Log'
      Enabled = False
      OnClick = pmLogClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object pmClose: TMenuItem
      Caption = 'Close'
    end
  end
end
