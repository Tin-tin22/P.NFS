object frCtrlMistral: TfrCtrlMistral
  Left = 0
  Top = 0
  Width = 830
  Height = 128
  TabOrder = 0
  DesignSize = (
    830
    128)
  object pnl_Launcher1: TPanel
    Left = 3
    Top = 4
    Width = 190
    Height = 121
    Color = clMoneyGreen
    ParentBackground = False
    TabOrder = 0
    object pnl_Left1: TPanel
      Left = 9
      Top = 10
      Width = 81
      Height = 100
      Color = clGray
      ParentBackground = False
      TabOrder = 0
      OnClick = pnl_Left1Click
    end
    object pnl_Left2: TPanel
      Left = 96
      Top = 10
      Width = 81
      Height = 100
      Color = clGray
      ParentBackground = False
      TabOrder = 1
      OnClick = pnl_Left2Click
    end
  end
  object pnl_Launcher2: TPanel
    Left = 637
    Top = 4
    Width = 190
    Height = 120
    Anchors = [akTop, akRight]
    Color = clMoneyGreen
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      190
      120)
    object pnl_Right1: TPanel
      Left = 13
      Top = 10
      Width = 81
      Height = 100
      Anchors = [akTop, akRight]
      Color = clGray
      ParentBackground = False
      TabOrder = 0
      OnClick = pnl_Right1Click
    end
    object pnl_Right2: TPanel
      Left = 100
      Top = 10
      Width = 81
      Height = 100
      Anchors = [akTop, akRight]
      Color = clGray
      ParentBackground = False
      TabOrder = 1
      OnClick = pnl_Right2Click
    end
  end
end
