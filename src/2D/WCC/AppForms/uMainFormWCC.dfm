object fMainWCC: TfMainWCC
  Left = 2
  Top = 816
  Caption = 'Weapon Console Control'
  ClientHeight = 154
  ClientWidth = 346
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseDown = FormMouseDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object spbRun: TSpeedButton
    Left = 8
    Top = 8
    Width = 89
    Height = 41
    AllowAllUp = True
    GroupIndex = 2
    Down = True
    Caption = 'Connected'
    OnClick = spbRunClick
  end
  object mmLogs: TMemo
    Left = 0
    Top = 56
    Width = 346
    Height = 98
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitHeight = 99
  end
  object MainMenu1: TMainMenu
    Left = 288
    Top = 8
    object mnProgram1: TMenuItem
      Caption = '&Program'
      object mnOpenScenario: TMenuItem
        Caption = 'Open Scenario'
        OnClick = mnOpenScenarioClick
      end
      object mnCloseScene: TMenuItem
        Caption = 'CloseScenario'
        OnClick = mnCloseSceneClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object mnExit1: TMenuItem
        Caption = '&Exit'
        OnClick = mnExit1Click
      end
    end
    object mnMultiplayer1: TMenuItem
      Caption = '&Multiplayer'
      object ConnectServer1: TMenuItem
        Caption = 'Connect Server'
        OnClick = ConnectServer1Click
      end
      object mnDisconnect1: TMenuItem
        Caption = 'Disconnect'
        OnClick = mnDisconnect1Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object NetSetting1: TMenuItem
        Caption = 'Net Setting'
        OnClick = NetSetting1Click
      end
    end
    object mnView: TMenuItem
      Caption = '&View'
      object mnMapWindow1: TMenuItem
        Caption = 'Map Window'
        Visible = False
        OnClick = mnMapWindow1Click
      end
      object mnMapControl1: TMenuItem
        Caption = 'Map Control'
        OnClick = mnMapControl1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
    end
    object Map1: TMenuItem
      Caption = 'Map'
      Visible = False
      object mnOpenGeoset1: TMenuItem
        Caption = 'Open Geoset'
        OnClick = mnOpenGeoset1Click
      end
      object mnCloseGeoset: TMenuItem
        Caption = 'Close Geoset'
      end
    end
    object mnWCC: TMenuItem
      Caption = 'WCC'
      object PanelKiriAtas1: TMenuItem
        Caption = 'Panel Kiri Atas'
        OnClick = PanelKiriAtas1Click
      end
      object PanelKiriBawah1: TMenuItem
        Caption = 'Panel Kiri Bawah'
        OnClick = PanelKiriBawah1Click
      end
      object PanelTengah1: TMenuItem
        Caption = 'Panel Tengah'
        OnClick = PanelTengah1Click
      end
      object PanelKananAtas1: TMenuItem
        Caption = 'Panel Kanan Atas'
        OnClick = PanelKananAtas1Click
      end
      object PanelKananBawah1: TMenuItem
        Caption = 'Panel Kanan Bawah'
        OnClick = PanelKananBawah1Click
      end
    end
  end
  object OpenScenDialog: TOpenDialog
    Filter = 'Scenario|*.ini'
    InitialDir = ' '
    Left = 256
    Top = 8
  end
  object OpenDialog1: TOpenDialog
    Left = 208
  end
end
