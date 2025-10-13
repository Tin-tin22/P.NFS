object frmDeveloper: TfrmDeveloper
  Left = 980
  Top = 800
  Width = 420
  Height = 188
  AlphaBlend = True
  AlphaBlendValue = 192
  Caption = 'frmDeveloper'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 409
    Height = 153
    ActivePage = tsGeneral
    TabOrder = 0
    TabPosition = tpBottom
    object tsGeneral: TTabSheet
      Caption = 'tsGeneral'
      object Label1: TLabel
        Left = 16
        Top = 16
        Width = 29
        Height = 13
        Caption = 'Timer '
      end
      object Label2: TLabel
        Left = 16
        Top = 48
        Width = 37
        Height = 26
        Caption = 'Repaint'#13#10'cycle'
      end
      object Edit1: TEdit
        Left = 64
        Top = 16
        Width = 49
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        TabOrder = 0
        Text = '1'
        OnKeyDown = Edit1KeyDown
      end
      object Edit2: TEdit
        Left = 64
        Top = 48
        Width = 49
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        TabOrder = 1
        Text = '1'
        OnKeyDown = Edit2KeyDown
      end
      object CheckBox3: TCheckBox
        Left = 120
        Top = 16
        Width = 65
        Height = 17
        Caption = 'Zero'
        TabOrder = 2
        OnClick = CheckBox3Click
      end
    end
    object tsShip: TTabSheet
      Caption = 'tsShip'
      ImageIndex = 4
      object Label4: TLabel
        Left = 16
        Top = 16
        Width = 48
        Height = 13
        Caption = 'Unique ID'
      end
      object Label8: TLabel
        Left = 8
        Top = 40
        Width = 52
        Height = 13
        Caption = 'Speed(Kts)'
      end
      object Label9: TLabel
        Left = 8
        Top = 64
        Width = 40
        Height = 13
        Caption = 'Heading'
      end
      object Edit4: TEdit
        Left = 72
        Top = 16
        Width = 73
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        TabOrder = 0
        OnKeyDown = Edit4KeyDown
      end
      object Edit7: TEdit
        Left = 72
        Top = 40
        Width = 41
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        TabOrder = 1
        Text = '20'
        OnKeyDown = Edit7KeyDown
      end
      object Edit8: TEdit
        Left = 72
        Top = 64
        Width = 41
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        TabOrder = 2
        Text = '360'
        OnKeyDown = Edit8KeyDown
      end
    end
    object tsTDC: TTabSheet
      Caption = 'tsTDC'
      ImageIndex = 1
    end
    object tsRadar: TTabSheet
      Caption = 'tsRadar'
      ImageIndex = 2
      object Label3: TLabel
        Left = 16
        Top = 24
        Width = 24
        Height = 13
        Caption = 'RPM'
      end
      object Edit3: TEdit
        Left = 48
        Top = 16
        Width = 49
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        TabOrder = 0
        Text = '10'
        OnKeyDown = Edit3KeyDown
      end
    end
    object tsEffect: TTabSheet
      Caption = 'tsEffect'
      ImageIndex = 5
      object Label6: TLabel
        Left = 200
        Top = 40
        Width = 32
        Height = 13
        Caption = 'Label6'
      end
      object Label7: TLabel
        Left = 16
        Top = 80
        Width = 33
        Height = 26
        Caption = 'Sweep'#13#10'Width'
      end
      object TrackBar1: TTrackBar
        Left = 8
        Top = 32
        Width = 193
        Height = 31
        Max = 255
        Frequency = 8
        TabOrder = 0
        OnChange = TrackBar1Change
      end
      object CheckBox1: TCheckBox
        Left = 16
        Top = 8
        Width = 73
        Height = 17
        Caption = 'Effect'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = CheckBox1Click
      end
      object CheckBox2: TCheckBox
        Left = 144
        Top = 8
        Width = 57
        Height = 17
        Caption = 'Noise'
        TabOrder = 2
        OnClick = CheckBox2Click
      end
      object edNoiseLevel: TEdit
        Left = 200
        Top = 8
        Width = 49
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        TabOrder = 3
        Text = '10'
        OnKeyDown = edNoiseLevelKeyDown
      end
      object Edit6: TEdit
        Left = 64
        Top = 80
        Width = 49
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        TabOrder = 4
        Text = '10'
        OnKeyDown = Edit6KeyDown
      end
    end
    object tsNetTest: TTabSheet
      Caption = 'tsNetTest'
      ImageIndex = 5
      object Button1: TButton
        Left = 256
        Top = 24
        Width = 75
        Height = 25
        Caption = 'Button1'
        TabOrder = 0
        OnClick = Button1Click
      end
    end
  end
end
