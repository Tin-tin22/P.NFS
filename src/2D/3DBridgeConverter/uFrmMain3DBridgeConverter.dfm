object frm3DBridgeConverter: Tfrm3DBridgeConverter
  Left = 0
  Top = 0
  Caption = '3DBridgeConverter'
  ClientHeight = 701
  ClientWidth = 947
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 947
    Height = 344
    Align = alTop
    TabOrder = 0
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 945
      Height = 41
      Align = alTop
      TabOrder = 0
      object Label1: TLabel
        Left = 32
        Top = 16
        Width = 161
        Height = 13
        Caption = 'Listen Port Server For 2D Bridge :'
      end
      object lbl2DServerPort: TLabel
        Left = 206
        Top = 16
        Width = 24
        Height = 13
        Caption = '5001'
      end
    end
    object Panel4: TPanel
      Left = 1
      Top = 42
      Width = 945
      Height = 301
      Align = alClient
      TabOrder = 1
      object mmoLogClient: TMemo
        Left = 1
        Top = 1
        Width = 169
        Height = 299
        Align = alLeft
        TabOrder = 0
      end
      object mmoLogClientData: TMemo
        Left = 170
        Top = 1
        Width = 774
        Height = 299
        Align = alClient
        TabOrder = 1
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 344
    Width = 947
    Height = 357
    Align = alClient
    TabOrder = 1
    object Panel5: TPanel
      Left = 1
      Top = 1
      Width = 945
      Height = 41
      Align = alTop
      TabOrder = 0
      object Label2: TLabel
        Left = 32
        Top = 13
        Width = 161
        Height = 13
        Caption = 'Listen Port Server For 3D Bridge :'
      end
      object lbl3DServerPrt: TLabel
        Left = 206
        Top = 13
        Width = 24
        Height = 13
        Caption = '5002'
      end
    end
    object Panel6: TPanel
      Left = 1
      Top = 42
      Width = 945
      Height = 314
      Align = alClient
      TabOrder = 1
      object mmoLog: TMemo
        Left = 170
        Top = 1
        Width = 774
        Height = 312
        Align = alClient
        BevelInner = bvLowered
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
      end
      object lbClients: TListBox
        Left = 1
        Top = 1
        Width = 169
        Height = 312
        Align = alLeft
        ItemHeight = 13
        TabOrder = 1
      end
    end
  end
end
