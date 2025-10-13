object frmCMSetting: TfrmCMSetting
  Left = 1900
  Top = 269
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Client Setting'
  ClientHeight = 577
  ClientWidth = 623
  Color = clGray
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 9
    Width = 609
    Height = 168
    Caption = 'Cubicle Setting'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnEnter = KeMaster
    object Label1: TLabel
      Left = 286
      Top = 66
      Width = 34
      Height = 16
      Caption = 'NAMA'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 286
      Top = 21
      Width = 12
      Height = 16
      Caption = 'ID'
      FocusControl = DBEdit2
    end
    object DBGrid1: TDBGrid
      Left = 11
      Top = 22
      Width = 262
      Height = 133
      DataSource = dstblCM
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -13
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnEnter = KeMaster
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'ID'
          Title.Alignment = taCenter
          Width = 32
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NAMA'
          Width = 182
          Visible = True
        end>
    end
    object DBEdit1: TDBEdit
      Left = 286
      Top = 82
      Width = 226
      Height = 24
      DataField = 'NAMA'
      DataSource = dstblCM
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnEnter = KeMaster
    end
    object DBEdit2: TDBEdit
      Left = 286
      Top = 37
      Width = 81
      Height = 24
      Color = clInfoBk
      DataField = 'ID'
      DataSource = dstblCM
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnEnter = KeMaster
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 181
    Width = 609
    Height = 340
    Caption = 'Console Setting'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnEnter = KeDetail
    object Label3: TLabel
      Left = 406
      Top = 20
      Width = 33
      Height = 16
      Caption = 'Name'
      FocusControl = DBEdit3
    end
    object Label6: TLabel
      Left = 286
      Top = 20
      Width = 61
      Height = 16
      Caption = 'IP Address'
      FocusControl = DBEdit6
    end
    object Label4: TLabel
      Left = 12
      Top = 287
      Width = 66
      Height = 16
      Caption = 'Parameters'
    end
    object Label7: TLabel
      Left = 286
      Top = 152
      Width = 52
      Height = 16
      Caption = 'Launcher'
    end
    object lbl1: TLabel
      Left = 288
      Top = 238
      Width = 71
      Height = 16
      Caption = 'MACaddress'
    end
    object DBGrid2: TDBGrid
      Left = 11
      Top = 22
      Width = 262
      Height = 259
      DataSource = dstblDetCM
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -13
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnEnter = KeDetail
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'PC_IP'
          Title.Alignment = taCenter
          Title.Caption = 'IP'
          Width = 83
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PC_NAME'
          Title.Caption = 'Name'
          Width = 131
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PC_MAC'
          Visible = True
        end>
    end
    object DBEdit3: TDBEdit
      Left = 406
      Top = 36
      Width = 114
      Height = 24
      DataField = 'PC_NAME'
      DataSource = dstblDetCM
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnEnter = KeDetail
    end
    object DBRadioGroup1: TDBRadioGroup
      Left = 286
      Top = 80
      Width = 275
      Height = 55
      Caption = 'Application Type'
      Columns = 3
      DataField = 'APP_TIPE'
      DataSource = dstblDetCM
      Items.Strings = (
        '2D'
        '3D Server'
        '3D Observer'
        '3D Weapon')
      ParentBackground = True
      TabOrder = 2
      Values.Strings = (
        '0'
        '1'
        '2'
        '3')
      OnEnter = KeDetail
    end
    object DBEdit6: TDBEdit
      Left = 285
      Top = 36
      Width = 116
      Height = 24
      Color = clInfoBk
      DataField = 'PC_IP'
      DataSource = dstblDetCM
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnEnter = KeDetail
    end
    object DBComboBox1: TDBComboBox
      Left = 286
      Top = 173
      Width = 235
      Height = 24
      DataField = 'APP_NAME'
      DataSource = dstblDetCM
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      Items.Strings = (
        'didServer.exe'
        'didLauncher.exe'
        'TDC.exe'
        'WCC.exe')
      ParentFont = False
      TabOrder = 3
      OnEnter = KeDetail
    end
    object DBComboBox2: TDBComboBox
      Left = 12
      Top = 305
      Width = 581
      Height = 24
      DataField = 'APP_PARAMS'
      DataSource = dstblDetCM
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      Items.Strings = (
        'didGameServer --port 7000 --ship "ships.xml" --fullscreen true'
        'didGameServer --port 7000 --ship "ships.xml" --fullscreen false'
        '--port 7000 --ship "ships.xml"'
        '--port 7000 --use "ANJUNGAN" --fullscreenmode true'
        '--port 7000 --use "ANJUNGAN"'
        '..\..\TDC\'
        '..\..\WCC\'
        '..\..\RADAR\'
        ' ')
      ParentFont = False
      TabOrder = 4
      OnEnter = KeDetail
    end
    object dbedtPC_MAC: TDBEdit
      Left = 285
      Top = 258
      Width = 236
      Height = 24
      Color = clInfoBk
      DataField = 'PC_MAC'
      DataSource = dstblDetCM
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnEnter = KeDetail
    end
    object dbedtAPP_NAME_2: TDBEdit
      Left = 285
      Top = 202
      Width = 236
      Height = 24
      Color = clInfoBk
      DataField = 'APP_NAME_2'
      DataSource = dstblDetCM
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnEnter = KeDetail
    end
  end
  object btnNew: TAdvSmoothButton
    Left = 8
    Top = 536
    Width = 68
    Height = 26
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
    Caption = 'New'
    Color = clBlack
    ParentFont = False
    TabOrder = 2
    Version = '1.6.9.4'
    OnClick = btnNewClick
  end
  object btnDelete: TAdvSmoothButton
    Left = 80
    Top = 536
    Width = 68
    Height = 26
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
    Caption = 'Delete'
    Color = clBlack
    ParentFont = False
    TabOrder = 3
    Enabled = False
    Version = '1.6.9.4'
    OnClick = btnDeleteClick
  end
  object btnSave: TAdvSmoothButton
    Left = 152
    Top = 536
    Width = 68
    Height = 26
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
    Caption = 'Save'
    Color = clBlack
    ParentFont = False
    TabOrder = 4
    Enabled = False
    Version = '1.6.9.4'
    OnClick = btnSaveClick
  end
  object btnCancel: TAdvSmoothButton
    Left = 224
    Top = 536
    Width = 68
    Height = 26
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
    TabOrder = 5
    Version = '1.6.9.4'
    OnClick = btnCancelClick
  end
  object btnClose: TAdvSmoothButton
    Left = 542
    Top = 536
    Width = 68
    Height = 26
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
    TabOrder = 6
    Version = '1.6.9.4'
    OnClick = btnCloseClick
  end
  object tblCM: TZQuery
    Connection = DataModule1.EmuConn
    BeforeDelete = tblCMBeforeDelete
    SQL.Strings = (
      'select * from cm_cubicle'
      'order by ID')
    Params = <>
    Left = 168
    Top = 73
    object tblCMID: TIntegerField
      Alignment = taLeftJustify
      DisplayWidth = 6
      FieldName = 'ID'
      Required = True
    end
    object tblCMNAMA: TWideStringField
      FieldName = 'NAMA'
      Size = 50
    end
  end
  object dstblCM: TDataSource
    DataSet = tblCM
    Left = 216
    Top = 72
  end
  object dstblDetCM: TDataSource
    DataSet = tblDetCM
    Left = 176
    Top = 280
  end
  object tblDetCM: TZQuery
    Connection = DataModule1.EmuConn
    BeforePost = tblDetCMBeforePost
    OnNewRecord = tblDetCMNewRecord
    SQL.Strings = (
      'select * from cm_console'
      'where PC_IDM=:ID'
      'order by ID')
    Params = <
      item
        DataType = ftUnknown
        Name = 'ID'
        ParamType = ptUnknown
      end>
    DataSource = dstblCM
    Left = 96
    Top = 281
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
        ParamType = ptUnknown
      end>
    object tblDetCMID: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'ID'
      Required = True
    end
    object wdstrngfldDetCMPC_IP: TWideStringField
      FieldName = 'PC_IP'
    end
    object tblDetCMPC_ID: TIntegerField
      FieldName = 'PC_ID'
    end
    object tblDetCMPC_IDM: TIntegerField
      FieldName = 'PC_IDM'
    end
    object wdstrngfldDetCMPC_NAME: TWideStringField
      FieldName = 'PC_NAME'
    end
    object tblDetCMAPP_TIPE: TIntegerField
      FieldName = 'APP_TIPE'
    end
    object wdstrngfldDetCMAPP_NAME: TWideStringField
      FieldName = 'APP_NAME'
    end
    object wdstrngfldDetCMAPP_PARAMS: TWideStringField
      FieldName = 'APP_PARAMS'
      Size = 400
    end
    object wdstrngfldDetCMPC_MAC: TWideStringField
      FieldName = 'PC_MAC'
    end
    object wdstrngfldDetCMAPP_NAME_2: TWideStringField
      FieldName = 'APP_NAME_2'
      Required = True
      Size = 50
    end
  end
  object ActiveSource: TDataSource
    DataSet = tblCM
    OnDataChange = ActiveSourceDataChange
    Left = 64
    Top = 120
  end
  object DQ: TZQuery
    Connection = DataModule1.EmuConn
    Params = <>
    Left = 296
    Top = 121
  end
end
