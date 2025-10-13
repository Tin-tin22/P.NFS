object frmCMSetting: TfrmCMSetting
  Left = 675
  Top = 147
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Client Setting'
  ClientHeight = 481
  ClientWidth = 549
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object btnNew: TSpeedButton
    Left = 8
    Top = 440
    Width = 68
    Height = 26
    Caption = 'New'
    OnClick = btnNewClick
  end
  object btnDelete: TSpeedButton
    Left = 80
    Top = 440
    Width = 68
    Height = 26
    Caption = 'Delete'
    Enabled = False
    OnClick = btnDeleteClick
  end
  object btnSave: TSpeedButton
    Left = 152
    Top = 440
    Width = 68
    Height = 26
    Caption = 'Save'
    Enabled = False
    OnClick = btnSaveClick
  end
  object btnCancel: TSpeedButton
    Left = 224
    Top = 440
    Width = 68
    Height = 26
    Caption = 'Cancel'
    OnClick = btnCancelClick
  end
  object btnClose: TSpeedButton
    Left = 470
    Top = 440
    Width = 68
    Height = 26
    Caption = 'Close'
    OnClick = btnCloseClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 9
    Width = 529
    Height = 168
    Caption = 'Console Setting'
    TabOrder = 0
    OnEnter = KeMaster
    object Label1: TLabel
      Left = 286
      Top = 66
      Width = 29
      Height = 13
      Caption = 'NAMA'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 286
      Top = 21
      Width = 11
      Height = 13
      Caption = 'ID'
      FocusControl = DBEdit2
    end
    object DBGrid1: TDBGrid
      Left = 11
      Top = 22
      Width = 262
      Height = 133
      DataSource = dstblCM
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
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
      Height = 21
      DataField = 'NAMA'
      DataSource = dstblCM
      TabOrder = 1
      OnEnter = KeMaster
    end
    object DBEdit2: TDBEdit
      Left = 286
      Top = 37
      Width = 81
      Height = 21
      Color = clInfoBk
      DataField = 'ID'
      DataSource = dstblCM
      TabOrder = 0
      OnEnter = KeMaster
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 181
    Width = 529
    Height = 249
    Caption = 'Detail Console'
    TabOrder = 1
    OnEnter = KeDetail
    object Label3: TLabel
      Left = 406
      Top = 20
      Width = 27
      Height = 13
      Caption = 'Name'
      FocusControl = DBEdit3
    end
    object Label5: TLabel
      Left = 286
      Top = 20
      Width = 22
      Height = 13
      Caption = 'C.ID'
      FocusControl = DBEdit5
    end
    object Label6: TLabel
      Left = 326
      Top = 20
      Width = 52
      Height = 13
      Caption = 'IP Address'
      FocusControl = DBEdit6
    end
    object Label4: TLabel
      Left = 12
      Top = 199
      Width = 55
      Height = 13
      Caption = 'Parameters'
    end
    object Label7: TLabel
      Left = 286
      Top = 152
      Width = 44
      Height = 13
      Caption = 'Launcher'
    end
    object DBGrid2: TDBGrid
      Left = 11
      Top = 22
      Width = 262
      Height = 172
      DataSource = dstblDetCM
      TabOrder = 6
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
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
        end>
    end
    object DBEdit3: TDBEdit
      Left = 406
      Top = 36
      Width = 114
      Height = 21
      DataField = 'PC_NAME'
      DataSource = dstblDetCM
      TabOrder = 2
      OnEnter = KeDetail
    end
    object DBRadioGroup1: TDBRadioGroup
      Left = 286
      Top = 80
      Width = 235
      Height = 55
      Caption = 'Application Type'
      Columns = 3
      DataField = 'APP_TIPE'
      DataSource = dstblDetCM
      Items.Strings = (
        '2D'
        '3D Server'
        '3D Client')
      TabOrder = 3
      Values.Strings = (
        '0'
        '1'
        '2')
      OnEnter = KeDetail
    end
    object DBEdit5: TDBEdit
      Left = 286
      Top = 36
      Width = 34
      Height = 21
      Color = clInfoBk
      DataField = 'ID'
      DataSource = dstblDetCM
      TabOrder = 0
      OnEnter = KeDetail
    end
    object DBEdit6: TDBEdit
      Left = 326
      Top = 36
      Width = 74
      Height = 21
      Color = clInfoBk
      DataField = 'PC_IP'
      DataSource = dstblDetCM
      TabOrder = 1
      OnEnter = KeDetail
    end
    object DBComboBox1: TDBComboBox
      Left = 286
      Top = 173
      Width = 233
      Height = 21
      DataField = 'APP_NAME'
      DataSource = dstblDetCM
      ItemHeight = 13
      Items.Strings = (
        'didServer.exe'
        'didLauncher.exe'
        'ECDIS.exe'
        'AIS.exe'
        'RADAR.exe')
      TabOrder = 4
      OnEnter = KeDetail
    end
    object DBComboBox2: TDBComboBox
      Left = 12
      Top = 217
      Width = 506
      Height = 21
      DataField = 'APP_PARAMS'
      DataSource = dstblDetCM
      ItemHeight = 13
      Items.Strings = (
        'didGameServer --port 7000 --ship "ships.xml" --fullscreen true'
        'didGameServer --port 7000 --ship "ships.xml" --fullscreen false'
        '--port 7000 --ship "ships.xml"'
        '--port 7000 --use "ANJUNGAN_L60" --fullscreenmode true'
        '--port 7000 --use "ANJUNGAN_L60"'
        '--port 7000 --use "ANJUNGAN_L30" --fullscreenmode true'
        '--port 7000 --use "ANJUNGAN_L30"'
        '--port 7000 --use "ANJUNGAN" --fullscreenmode true'
        '--port 7000 --use "ANJUNGAN"'
        '--port 7000 --use "ANJUNGAN_R30" --fullscreenmode true'
        '--port 7000 --use "ANJUNGAN_R30"'
        '--port 7000 --use "ANJUNGAN_R60" --fullscreenmode true'
        '--port 7000 --use "ANJUNGAN_R60"'
        '..\..\ECDIS\'
        '..\..\AIS\'
        '..\..\RADAR\')
      TabOrder = 5
      OnEnter = KeDetail
    end
  end
  object tblCM: TZQuery
    Connection = DM.EmuConn
    BeforeDelete = tblCMBeforeDelete
    Active = True
    SQL.Strings = (
      'select * from cm_set_dpms'
      'order by ID')
    Params = <>
    Left = 184
    Top = 73
    object tblCMID: TIntegerField
      Alignment = taLeftJustify
      DisplayWidth = 6
      FieldName = 'ID'
      Required = True
    end
    object tblCMNAMA: TStringField
      DisplayWidth = 60
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
    Left = 224
    Top = 280
  end
  object tblDetCM: TZQuery
    Connection = DM.EmuConn
    BeforePost = tblDetCMBeforePost
    OnNewRecord = tblDetCMNewRecord
    Active = True
    SQL.Strings = (
      'select * from cm_set_app'
      'where PC_IDM=:ID'
      'order by ID')
    Params = <
      item
        DataType = ftUnknown
        Name = 'ID'
        ParamType = ptUnknown
      end>
    DataSource = dstblCM
    Left = 192
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
    object tblDetCMPC_IP: TStringField
      FieldName = 'PC_IP'
    end
    object tblDetCMPC_ID: TIntegerField
      FieldName = 'PC_ID'
    end
    object tblDetCMPC_IDM: TIntegerField
      FieldName = 'PC_IDM'
    end
    object tblDetCMPC_NAME: TStringField
      FieldName = 'PC_NAME'
      Size = 50
    end
    object tblDetCMAPP_TIPE: TIntegerField
      FieldName = 'APP_TIPE'
    end
    object tblDetCMAPP_NAME: TStringField
      FieldName = 'APP_NAME'
      Size = 50
    end
    object tblDetCMAPP_PARAMS: TStringField
      FieldName = 'APP_PARAMS'
      Size = 100
    end
  end
  object ActiveSource: TDataSource
    DataSet = tblCM
    OnDataChange = ActiveSourceDataChange
    Left = 64
    Top = 120
  end
  object DQ: TZQuery
    Connection = DM.EmuConn
    Params = <>
    Left = 424
    Top = 57
  end
end
