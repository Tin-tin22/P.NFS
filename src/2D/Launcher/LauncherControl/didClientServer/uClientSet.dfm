object frmSetting: TfrmSetting
  Left = 641
  Top = 250
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Setting'
  ClientHeight = 324
  ClientWidth = 284
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label4: TLabel
    Left = 485
    Top = 298
    Width = 20
    Height = 13
    Caption = 'Port'
    Visible = False
  end
  object Label5: TLabel
    Left = 485
    Top = 257
    Width = 20
    Height = 13
    Caption = 'Port'
    Visible = False
  end
  object Button2: TButton
    Left = 58
    Top = 287
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'CANCEL'
    ModalResult = 2
    TabOrder = 0
  end
  object Button1: TButton
    Left = 134
    Top = 287
    Width = 75
    Height = 25
    Caption = 'SAVE'
    ModalResult = 1
    TabOrder = 1
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 408
    Top = 120
    Width = 185
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
  end
  object gbDB: TGroupBox
    Left = 8
    Top = 136
    Width = 265
    Height = 138
    Caption = 'Database Setting'
    TabOrder = 3
    object Label2: TLabel
      Left = 13
      Top = 26
      Width = 39
      Height = 13
      Caption = 'Address'
    end
    object Label8: TLabel
      Left = 13
      Top = 100
      Width = 22
      Height = 13
      Caption = 'Pass'
    end
    object Label7: TLabel
      Left = 13
      Top = 74
      Width = 22
      Height = 13
      Caption = 'User'
    end
    object Label6: TLabel
      Left = 13
      Top = 49
      Width = 27
      Height = 13
      Caption = 'Name'
    end
    object eDBServer: TComboBox
      Left = 68
      Top = 23
      Width = 173
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = 'localhost'
      Items.Strings = (
        '192.168.0.167'
        '192.168.0.151'
        'server'
        'localhost')
    end
    object eDBName: TEdit
      Left = 68
      Top = 46
      Width = 173
      Height = 21
      TabOrder = 1
    end
    object eDBUser: TEdit
      Left = 68
      Top = 72
      Width = 173
      Height = 21
      TabOrder = 2
    end
    object eDBPass: TEdit
      Left = 68
      Top = 98
      Width = 173
      Height = 21
      PasswordChar = '*'
      TabOrder = 3
    end
  end
  object gbServer: TGroupBox
    Left = 8
    Top = 8
    Width = 265
    Height = 113
    Caption = 'Server'
    TabOrder = 4
    object Label3: TLabel
      Left = 13
      Top = 65
      Width = 48
      Height = 13
      Caption = '3D Server'
    end
    object Label1: TLabel
      Left = 13
      Top = 24
      Width = 48
      Height = 13
      Caption = '2D Server'
    end
    object e3DServerIP: TComboBox
      Left = 68
      Top = 64
      Width = 174
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = 'localhost'
      Items.Strings = (
        '192.168.1.3'
        '192.168.1.251'
        'server'
        'localhost')
    end
    object e2DServerIP: TComboBox
      Left = 68
      Top = 22
      Width = 174
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      Text = 'localhost'
      Items.Strings = (
        '192.168.1.3'
        '192.168.1.251'
        'server'
        'localhost')
    end
  end
  object e3DServerPort: TEdit
    Left = 536
    Top = 296
    Width = 54
    Height = 21
    ParentColor = True
    TabOrder = 5
    Visible = False
  end
  object e2DServerPort: TEdit
    Left = 536
    Top = 254
    Width = 54
    Height = 21
    ParentColor = True
    TabOrder = 6
    Visible = False
  end
end
