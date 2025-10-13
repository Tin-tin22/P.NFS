inherited FrmTactical_display_area: TFrmTactical_display_area
  Left = 139
  Top = 27
  Width = 1034
  Height = 741
  Caption = 'Tactical Display Area'
  Color = clMedGray
  Menu = MainMenu1
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Map: TMap
    Top = 41
    Width = 1026
    Height = 654
    TabOrder = 1
    ControlData = {
      8B1A0600D885000037660000010000000F0000FF0D47656F44696374696F6E61
      727905456D70747900E8030000000000000000000002000E001E000000000000
      0000000000000000000000000000000000000000000600010000000000500001
      010000640000000001F4010000050000800C000000000000000000000000FFFF
      FF000100000000000000000000000000000000000000000000000352E30B918F
      CE119DE300AA004BB851010000009001B0710B0005417269616C000352E30B91
      8FCE119DE300AA004BB8510100000090019C51030005417269616C0000000000
      00000000000000000000000000000000000000000000000000000000000000D8
      ECF8000000000000000001370000000000D8ECF8000000000000000352E30B91
      8FCE119DE300AA004BB851010000009001DC7C010005417269616C000352E30B
      918FCE119DE300AA004BB851010200009001A42C02000B4D61702053796D626F
      6C730000000000000001000100FFFFFF000200D8ECF800000000000001000000
      01000118010000D802150001000000000000001C000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000002
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8076C000000000008056C0000000000080764000000000008056400100000018
      010000D802150001000000000000001C00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000200000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000090E02120D0000000E
      000000D8EC1300090E02128A0E021200000000E8ED1300000000000000000000
      000088B3400000000000408F400001000001}
  end
  object CoolBar1: TCoolBar [1]
    Left = 0
    Top = 0
    Width = 1026
    Height = 41
    Bands = <
      item
        Control = ToolBar1
        ImageIndex = -1
        MinHeight = 30
        Width = 1022
      end>
    object ToolBar1: TToolBar
      Left = 9
      Top = 0
      Width = 1009
      Height = 30
      AutoSize = True
      ButtonHeight = 27
      Caption = 'ToolBar1'
      EdgeInner = esNone
      TabOrder = 0
      object VrBitmapButton1: TVrBitmapButton
        Left = 0
        Top = 2
        Width = 27
        Height = 27
        Color = clMedGray
      end
      object VrBitmapButton2: TVrBitmapButton
        Left = 27
        Top = 2
        Width = 27
        Height = 27
        Color = clMedGray
      end
      object VrBitmapButton3: TVrBitmapButton
        Left = 54
        Top = 2
        Width = 27
        Height = 27
        Color = clMedGray
      end
      object VrBitmapButton4: TVrBitmapButton
        Left = 81
        Top = 2
        Width = 27
        Height = 27
        Color = clMedGray
      end
      object VrBitmapButton5: TVrBitmapButton
        Left = 108
        Top = 2
        Width = 27
        Height = 27
        Color = clMedGray
      end
      object VrBitmapButton6: TVrBitmapButton
        Left = 135
        Top = 2
        Width = 27
        Height = 27
        Color = clMedGray
      end
      object VrBitmapButton7: TVrBitmapButton
        Left = 162
        Top = 2
        Width = 27
        Height = 27
        Color = clMedGray
      end
      object VrBitmapButton8: TVrBitmapButton
        Left = 189
        Top = 2
        Width = 27
        Height = 27
        Color = clMedGray
      end
      object VrBitmapButton9: TVrBitmapButton
        Left = 216
        Top = 2
        Width = 27
        Height = 27
        Color = clMedGray
      end
      object VrBitmapButton10: TVrBitmapButton
        Left = 243
        Top = 2
        Width = 27
        Height = 27
        Color = clMedGray
      end
      object VrBitmapButton11: TVrBitmapButton
        Left = 270
        Top = 2
        Width = 27
        Height = 27
        Color = clMedGray
      end
      object VrBitmapButton12: TVrBitmapButton
        Left = 297
        Top = 2
        Width = 27
        Height = 27
        Color = clMedGray
      end
    end
  end
  inherited PopupMenu1: TPopupMenu
    Left = 200
    Top = 88
  end
  inherited ColorDialog1: TColorDialog
    Left = 267
    Top = 42
  end
  object MainMenu1: TMainMenu
    Left = 448
    Top = 16
    object View1: TMenuItem
      Caption = 'View'
      object Preferences1: TMenuItem
        Caption = 'Preferences ...'
      end
      object New1: TMenuItem
        Caption = 'New'
      end
      object Quit1: TMenuItem
        Caption = 'Quit'
      end
    end
    object Area1: TMenuItem
      Caption = 'Area'
      object FitWindowtoRange1: TMenuItem
        Caption = 'Fit Window to Range'
      end
      object Gridsize1: TMenuItem
        Caption = 'Grid size'
        object Fine1: TMenuItem
          Caption = 'Fine'
        end
        object Normal1: TMenuItem
          Caption = 'Normal'
        end
        object Coarse1: TMenuItem
          Caption = 'Coarse'
        end
      end
    end
    object Filters1: TMenuItem
      Caption = 'Filters'
      object Display1: TMenuItem
        Caption = 'Display ...'
      end
      object Figures1: TMenuItem
        Caption = 'Figures ...'
      end
      object Labels1: TMenuItem
        Caption = 'Labels ...'
      end
      object racks1: TMenuItem
        Caption = 'Tracks ...'
      end
    end
    object acticos1: TMenuItem
      Caption = 'Tacticos'
      object ICM1: TMenuItem
        Caption = 'ICM ...'
      end
      object RAMtrackseq1: TMenuItem
        Caption = 'RAM track seq ...'
      end
      object SGOdefinition1: TMenuItem
        Caption = 'SGO definition ...'
      end
      object DAReposition1: TMenuItem
        Caption = 'TDA Reposition ...'
      end
    end
    object Map1: TMenuItem
      Caption = 'Map'
      object RTFSelections1: TMenuItem
        Caption = 'RTF Selections ...'
      end
      object EcisMapSettings1: TMenuItem
        Caption = 'Ecis Map Settings ...'
      end
      object EcisGeneralSettings1: TMenuItem
        Caption = 'Ecis General Settings ...'
      end
      object EcisObjectInfo1: TMenuItem
        Caption = 'Ecis Object Info ...'
      end
    end
  end
end
