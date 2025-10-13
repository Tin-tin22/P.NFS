object frmRecordsList: TfrmRecordsList
  Left = 434
  Top = 210
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Records List'
  ClientHeight = 355
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 480
    Height = 314
    Align = alClient
    BorderWidth = 5
    TabOrder = 0
    object lvScenario: TListView
      Left = 6
      Top = 6
      Width = 468
      Height = 302
      Align = alClient
      Columns = <
        item
          Caption = 'File'
          Width = 150
        end
        item
          Caption = 'Scenario'
          Width = 150
        end
        item
          Caption = 'Date / Time'
          Width = 150
        end
        item
          Width = 10
        end>
      GridLines = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnChange = lvScenarioChange
      OnDblClick = lvScenarioDblClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 314
    Width = 480
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Color = clGray
    ParentBackground = False
    TabOrder = 1
    object Button1: TAdvSmoothButton
      Left = 304
      Top = 7
      Width = 75
      Height = 25
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
      Caption = 'OK'
      Color = clBlack
      ParentFont = False
      TabOrder = 0
      Version = '1.6.9.4'
      OnClick = Button1Click
    end
    object Button2: TAdvSmoothButton
      Left = 385
      Top = 6
      Width = 75
      Height = 25
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
      TabOrder = 1
      Version = '1.6.9.4'
      OnClick = Button2Click
    end
  end
end
