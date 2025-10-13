object frCtrl40: TfrCtrl40
  Left = 0
  Top = 0
  Width = 830
  Height = 120
  Color = clMoneyGreen
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  DesignSize = (
    830
    120)
  object btn_FireC40: TSpeedButton
    Left = 8
    Top = 10
    Width = 80
    Height = 100
    AllowAllUp = True
    GroupIndex = 1
    Caption = 'FIRE'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Gill Sans MT'
    Font.Style = []
    ParentFont = False
    OnClick = btn_FireC40Click
  end
  object btn_R10: TSpeedButton
    Left = 484
    Top = 10
    Width = 80
    Height = 100
    AllowAllUp = True
    Anchors = [akTop, akRight]
    GroupIndex = 2
    Caption = '10'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Gill Sans MT'
    Font.Style = []
    ParentFont = False
    OnClick = btn_R10Click
  end
  object btn_R50: TSpeedButton
    Left = 656
    Top = 10
    Width = 80
    Height = 100
    AllowAllUp = True
    Anchors = [akTop, akRight]
    GroupIndex = 2
    Caption = '50'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Gill Sans MT'
    Font.Style = []
    ParentFont = False
    OnClick = btn_R10Click
  end
  object btn_R30: TSpeedButton
    Left = 571
    Top = 10
    Width = 80
    Height = 100
    AllowAllUp = True
    Anchors = [akTop, akRight]
    GroupIndex = 2
    Caption = '30'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Gill Sans MT'
    Font.Style = []
    ParentFont = False
    OnClick = btn_R10Click
  end
  object btn_R100: TSpeedButton
    Left = 741
    Top = 10
    Width = 80
    Height = 100
    AllowAllUp = True
    Anchors = [akTop, akRight]
    GroupIndex = 2
    Caption = '100'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Gill Sans MT'
    Font.Style = []
    ParentFont = False
    OnClick = btn_R10Click
  end
  object btn_Salvo40: TSpeedButton
    Left = 94
    Top = 10
    Width = 80
    Height = 100
    AllowAllUp = True
    GroupIndex = 1
    Caption = 'SALVO'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Gill Sans MT'
    Font.Style = []
    ParentFont = False
    OnClick = btn_FireC40Click
  end
  object pnl_C40Lock: TPanel
    Left = 180
    Top = 10
    Width = 80
    Height = 101
    Color = clGreen
    ParentBackground = False
    TabOrder = 0
    OnClick = pnl_C40LockClick
  end
end
