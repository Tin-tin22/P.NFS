object fMainTorpedo: TfMainTorpedo
  Left = 0
  Top = 0
  Anchors = [akLeft]
  Caption = 'Torpedo Control System'
  ClientHeight = 308
  ClientWidth = 328
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesigned
  Visible = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseDown = FormMouseDown
  PixelsPerInch = 96
  TextHeight = 13
  object mmLogs: TMemo
    Left = 0
    Top = 57
    Width = 328
    Height = 251
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    WordWrap = False
    ExplicitWidth = 320
    ExplicitHeight = 247
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 328
    Height = 57
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    OnMouseDown = FormMouseDown
    ExplicitWidth = 320
    object spbRun: TSpeedButton
      Left = 213
      Top = 8
      Width = 89
      Height = 41
      AllowAllUp = True
      GroupIndex = 2
      Down = True
      Caption = 'Running'
      OnClick = spbRunClick
    end
    object SpeedButton1: TSpeedButton
      Left = -50
      Top = 0
      Width = 64
      Height = 48
      Flat = True
      OnClick = SpeedButton1Click
    end
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
      end
      object mnCloseGeoset: TMenuItem
        Caption = 'Close Geoset'
      end
    end
    object mnTDC_1: TMenuItem
      Caption = 'TDC'
      object mnDC1Tengah1: TMenuItem
        Caption = 'L P D'
        OnClick = mnDC1Tengah1Click
      end
      object mniMainPanel: TMenuItem
        Caption = 'Main Control PAnel'
        OnClick = mniMainPanelClick
      end
      object mniTechnicalPanel: TMenuItem
        Caption = 'Technical Control Panel'
        OnClick = mniTechnicalPanelClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object mniLeftPanel: TMenuItem
        Caption = 'Left Control Panel'
        OnClick = mniLeftPanelClick
      end
      object mniBottomPanel: TMenuItem
        Caption = 'Bottom Control Panel'
        OnClick = mniBottomPanelClick
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
    Left = 200
    Top = 16
  end
end
