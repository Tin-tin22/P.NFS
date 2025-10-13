object frm_Main: Tfrm_Main
  Left = 0
  Top = 150
  Caption = 'Main Control Panel RBU6000'
  ClientHeight = 140
  ClientWidth = 332
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mm1
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object mmo1: TMemo
    Left = 0
    Top = 65
    Width = 332
    Height = 75
    Align = alClient
    Lines.Strings = (
      'mmo1')
    TabOrder = 0
    ExplicitHeight = 90
  end
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 332
    Height = 65
    Align = alTop
    TabOrder = 1
    object btnConnect: TSpeedButton
      Left = 24
      Top = 16
      Width = 89
      Height = 33
      AllowAllUp = True
      GroupIndex = 3
      Down = True
      Caption = 'Connected'
      OnClick = btnConnectClick
    end
  end
  object mm1: TMainMenu
    Left = 432
    Top = 8
    object mniProgram: TMenuItem
      Caption = 'Program'
      object mniExit: TMenuItem
        Caption = 'Exit'
        OnClick = mniExitClick
      end
    end
    object mni: TMenuItem
      Caption = 'Multy Player'
      object mniConnect1: TMenuItem
        Caption = 'Connect'
        OnClick = mniConnect1Click
      end
      object mniDisconnect: TMenuItem
        Caption = 'Disconnect'
        OnClick = mniDisconnectClick
      end
      object mniNetSetting: TMenuItem
        Caption = 'NetSetting'
        OnClick = mniNetSettingClick
      end
    end
    object mniBurja1: TMenuItem
      Caption = 'Windows'
      object mniBurja: TMenuItem
        Caption = 'Burja'
        OnClick = mniBurjaClick
      end
      object mniN108Kiri1: TMenuItem
        Caption = '108 Kiri'
        OnClick = mniN108Kiri1Click
      end
      object mniN108Kanan1: TMenuItem
        Caption = '108 Kanan'
        OnClick = mniN108Kanan1Click
      end
    end
  end
end
