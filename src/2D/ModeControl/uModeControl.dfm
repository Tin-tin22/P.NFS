object fMainForm: TfMainForm
  Left = 0
  Top = 0
  Align = alBottom
  AutoSize = True
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsNone
  Caption = 'Firing Control'
  ClientHeight = 150
  ClientWidth = 830
  Color = 9815189
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = pm1
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object tmrConBridge: TTimer
    OnTimer = tmrConBridgeTimer
    Left = 64
    Top = 8
  end
  object pm1: TPopupMenu
    Left = 16
    Top = 8
    object pmNetSetting: TMenuItem
      Caption = 'Net Setting'
      OnClick = pmNetSettingClick
    end
    object pmLogMemo: TMenuItem
      Caption = 'Log Memo'
      OnClick = pmLogMemoClick
    end
    object pmClose: TMenuItem
      Caption = 'Close'
      OnClick = pmCloseClick
    end
  end
  object tmrGetValue: TTimer
    Left = 120
    Top = 8
  end
end
