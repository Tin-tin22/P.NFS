object TFLogBridge: TTFLogBridge
  Left = 419
  Top = 484
  Caption = 'Log Bridge'
  ClientHeight = 294
  ClientWidth = 1058
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMinimized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 1058
    Height = 294
    Align = alClient
    TabOrder = 0
    object pnlClient: TPanel
      Left = 1
      Top = 1
      Width = 256
      Height = 292
      Align = alLeft
      TabOrder = 0
      object mLogClient: TMemo
        Left = 1
        Top = 50
        Width = 254
        Height = 200
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object pnlClientUp: TPanel
        Left = 1
        Top = 1
        Width = 254
        Height = 49
        Align = alTop
        Caption = 'Log Client 3D'
        TabOrder = 1
      end
      object pnlClientBottom: TPanel
        Left = 1
        Top = 250
        Width = 254
        Height = 41
        Align = alBottom
        Caption = 'Not Connected'
        TabOrder = 2
      end
    end
    object pnlServer: TPanel
      Left = 257
      Top = 1
      Width = 264
      Height = 292
      Align = alLeft
      TabOrder = 1
      object mLogServer: TMemo
        Left = 1
        Top = 50
        Width = 262
        Height = 241
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object pnlServerUp: TPanel
        Left = 1
        Top = 1
        Width = 262
        Height = 49
        Align = alTop
        Caption = 'Log Server 2D'
        TabOrder = 1
      end
    end
    object pnlSetting: TPanel
      Left = 521
      Top = 1
      Width = 266
      Height = 292
      Align = alLeft
      TabOrder = 2
      object pnlSettingUp: TPanel
        Left = 1
        Top = 1
        Width = 264
        Height = 49
        Align = alTop
        Caption = 'Setting'
        TabOrder = 0
      end
      object mLogSetting: TMemo
        Left = 1
        Top = 50
        Width = 264
        Height = 241
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 1
      end
    end
    object pnlPacket: TPanel
      Left = 787
      Top = 1
      Width = 270
      Height = 292
      Align = alClient
      Caption = 'pnlPacket'
      TabOrder = 3
      object pnlUppacket: TPanel
        Left = 1
        Top = 1
        Width = 268
        Height = 49
        Align = alTop
        Caption = 'Packet'
        TabOrder = 0
      end
      object mmoPacket: TMemo
        Left = 1
        Top = 50
        Width = 268
        Height = 241
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 1
      end
    end
  end
end
