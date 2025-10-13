object frCtrlStrella: TfrCtrlStrella
  Left = 0
  Top = 0
  Width = 830
  Height = 128
  TabOrder = 0
  DesignSize = (
    830
    128)
  object pnl_Launcher1: TPanel
    Left = 4
    Top = 3
    Width = 400
    Height = 120
    Color = clMoneyGreen
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      400
      120)
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
      Top = 11
      Width = 81
      Height = 100
      Color = clGray
      ParentBackground = False
      TabOrder = 1
      OnClick = pnl_Left2Click
    end
    object pnl_Left3: TPanel
      Left = 224
      Top = 10
      Width = 81
      Height = 100
      Anchors = [akTop, akRight]
      Color = clGray
      ParentBackground = False
      TabOrder = 2
      OnClick = pnl_Left3Click
    end
    object pnl_Left4: TPanel
      Left = 311
      Top = 10
      Width = 81
      Height = 100
      Anchors = [akTop, akRight]
      Color = clGray
      ParentBackground = False
      TabOrder = 3
      OnClick = pnl_Left4Click
    end
  end
  object pnl_Launcher2: TPanel
    Left = 424
    Top = 3
    Width = 400
    Height = 120
    Anchors = [akTop, akRight]
    Color = clMoneyGreen
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      400
      120)
    object pnl_Right1: TPanel
      Left = 8
      Top = 11
      Width = 81
      Height = 100
      Color = clGray
      ParentBackground = False
      TabOrder = 0
      OnClick = pnl_Right1Click
    end
    object pnl_Right2: TPanel
      Left = 95
      Top = 10
      Width = 81
      Height = 100
      Color = clGray
      ParentBackground = False
      TabOrder = 1
      OnClick = pnl_Right2Click
    end
    object pnl_Right3: TPanel
      Left = 224
      Top = 10
      Width = 81
      Height = 100
      Anchors = [akTop, akRight]
      Color = clGray
      ParentBackground = False
      TabOrder = 2
      OnClick = pnl_Right3Click
    end
    object pnl_Right4: TPanel
      Left = 311
      Top = 10
      Width = 81
      Height = 100
      Anchors = [akTop, akRight]
      Color = clGray
      ParentBackground = False
      TabOrder = 3
      OnClick = pnl_Right4Click
    end
  end
end
