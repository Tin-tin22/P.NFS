object frmAcknowledgement: TfrmAcknowledgement
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'frmAcknowledgement'
  ClientHeight = 100
  ClientWidth = 250
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlAcknowledgement: TPanel
    Left = 0
    Top = 0
    Width = 250
    Height = 100
    Color = clTeal
    ParentBackground = False
    TabOrder = 0
    object pnlContent: TPanel
      Left = 5
      Top = 6
      Width = 240
      Height = 89
      BevelInner = bvLowered
      Color = clSilver
      ParentBackground = False
      TabOrder = 0
      object Label1: TLabel
        Left = 58
        Top = 14
        Width = 131
        Height = 13
        Caption = 'ER ? Acknowledgement'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnYes: TButton
        Left = 80
        Top = 51
        Width = 33
        Height = 25
        Caption = 'Yes'
        TabOrder = 0
        OnClick = btnYesClick
      end
      object btnNo: TButton
        Left = 119
        Top = 51
        Width = 33
        Height = 25
        Caption = 'No'
        TabOrder = 1
        OnClick = btnNoClick
      end
      object Panel1: TPanel
        Left = 13
        Top = 40
        Width = 209
        Height = 1
        TabOrder = 2
      end
    end
  end
end
