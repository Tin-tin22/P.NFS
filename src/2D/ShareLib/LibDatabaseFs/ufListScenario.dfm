object frmListScenario: TfrmListScenario
  Left = 694
  Top = 297
  Width = 318
  Height = 528
  Caption = 'List Available Scenario'
  Color = clGray
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lvListScen: TListView
    Left = 0
    Top = 0
    Width = 310
    Height = 365
    Align = alClient
    Columns = <
      item
        Caption = 'ID'
      end
      item
        Caption = 'Scenario Name'
        Width = 100
      end
      item
        Caption = 'Port'
        Width = 100
      end>
    GridLines = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnClick = lvListScenClick
    OnKeyPress = lvListScenKeyPress
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 365
    Width = 310
    Height = 136
    Align = alBottom
    Color = clGray
    TabOrder = 1
    object lblGameName: TLabel
      Left = 8
      Top = 37
      Width = 79
      Height = 16
      Caption = 'Game Name :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object btnRemove: TAdvSmoothButton
      Left = 14
      Top = 89
      Width = 89
      Height = 35
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
      TabOrder = 0
      Visible = False
      Version = '1.6.9.4'
      OnClick = btnRemoveClick
    end
    object btnOk: TAdvSmoothButton
      Left = 134
      Top = 89
      Width = 79
      Height = 35
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
      Caption = 'Ok'
      Color = clBlack
      ParentFont = False
      TabOrder = 1
      Enabled = False
      Version = '1.6.9.4'
      OnClick = btnOkClick
    end
    object btnClose: TAdvSmoothButton
      Left = 219
      Top = 89
      Width = 75
      Height = 35
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
      TabOrder = 2
      Version = '1.6.9.4'
      OnClick = btnCloseClick
    end
    object edtGameName: TEdit
      Left = 97
      Top = 35
      Width = 206
      Height = 21
      TabOrder = 3
      OnChange = edtGameNameChange
      OnKeyPress = edtGameNameKeyPress
    end
  end
end
