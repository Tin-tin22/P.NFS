object fMainTDC: TfMainTDC
  Left = 339
  Top = 200
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Tactical  Display  Console'
  ClientHeight = 152
  ClientWidth = 317
  Color = clBtnFace
  DefaultMonitor = dmDesktop
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
    Width = 317
    Height = 95
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    WordWrap = False
    ExplicitWidth = 334
    ExplicitHeight = 82
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 317
    Height = 57
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    OnMouseDown = FormMouseDown
    ExplicitWidth = 334
    object SpeedButton1: TSpeedButton
      Left = 280
      Top = 40
      Width = 64
      Height = 8
      Flat = True
      OnClick = SpeedButton1Click
    end
    object spbConnect: TSpeedButton
      Left = 8
      Top = 8
      Width = 89
      Height = 33
      AllowAllUp = True
      GroupIndex = 3
      Down = True
      Caption = 'Connected'
      OnClick = spbConnectClick
    end
    object SpeedButton2: TSpeedButton
      Left = 104
      Top = 8
      Width = 33
      Height = 33
      Flat = True
      OnClick = NetSetting1Click
    end
  end
  object MainMenu1: TMainMenu
    Left = 272
    object mnProgram1: TMenuItem
      Caption = '&Program'
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
      object mnDC1Kiri1: TMenuItem
        Caption = 'QEK Kiri'
        OnClick = mnDC1Kiri1Click
      end
      object mnDC1kanan1: TMenuItem
        Caption = 'QEK kanan'
        OnClick = mnDC1kanan1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object mnDC1KeyboardKiri1: TMenuItem
        Caption = 'MIK Kiri'
        OnClick = mnDC1KeyboardKiri1Click
      end
      object mnDC1KeyboardKanan1: TMenuItem
        Caption = 'MIK Kanan'
        OnClick = mnDC1KeyboardKanan1Click
      end
    end
  end
  object OpenScenDialog: TOpenDialog
    Filter = 'Scenario|*.ini'
    InitialDir = ' '
    Left = 240
  end
  object OpenDialog1: TOpenDialog
    Left = 208
  end
end
