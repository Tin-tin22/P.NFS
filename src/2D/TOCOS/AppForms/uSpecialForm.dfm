object frmDeveloper: TfrmDeveloper
  Left = 0
  Top = 0
  AlphaBlend = True
  AlphaBlendValue = 192
  Caption = 'frmDeveloper'
  ClientHeight = 189
  ClientWidth = 412
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 409
    Height = 185
    ActivePage = tsTest
    TabOrder = 0
    TabPosition = tpBottom
    object tsGeneral: TTabSheet
      Caption = 'tsGeneral'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
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
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
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
      Caption = 'tsTrack'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object SpeedButton1: TSpeedButton
        Left = 320
        Top = 8
        Width = 65
        Height = 22
        Caption = 'Track'
        OnClick = SpeedButton1Click
      end
      object SpeedButton2: TSpeedButton
        Left = 352
        Top = 128
        Width = 31
        Height = 22
        OnClick = SpeedButton2Click
      end
      object Label5: TLabel
        Left = 320
        Top = 40
        Width = 41
        Height = 13
        Caption = 'Set Halu'
      end
      object Label10: TLabel
        Left = 320
        Top = 80
        Width = 47
        Height = 13
        Caption = 'Set Cepat'
      end
      object lvTrack: TListView
        Left = 0
        Top = 0
        Width = 313
        Height = 145
        Columns = <
          item
            Caption = 'Track'
          end
          item
            Caption = 'Halu'
          end
          item
            Caption = 'Cepat'
          end
          item
            Caption = 'Jarak'
          end
          item
            Caption = 'Baringan'
          end>
        GridLines = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnSelectItem = lvTrackSelectItem
      end
      object edHalu: TEdit
        Left = 328
        Top = 56
        Width = 49
        Height = 21
        TabOrder = 1
        Text = 'edHalu'
      end
      object edCepat: TEdit
        Left = 328
        Top = 96
        Width = 49
        Height = 21
        TabOrder = 2
        Text = 'Edit5'
      end
    end
    object tsEffect: TTabSheet
      Caption = 'tsEffect'
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
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
      object Label3: TLabel
        Left = 264
        Top = 8
        Width = 24
        Height = 13
        Caption = 'RPM'
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
        Left = 88
        Top = 8
        Width = 57
        Height = 17
        Caption = 'Noise'
        TabOrder = 2
        OnClick = CheckBox2Click
      end
      object edNoiseLevel: TEdit
        Left = 144
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
      object Edit3: TEdit
        Left = 272
        Top = 24
        Width = 49
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        TabOrder = 5
        Text = '10'
        OnKeyDown = Edit3KeyDown
      end
    end
    object tsTest: TTabSheet
      Caption = 'tsTest'
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object SpeedButton3: TSpeedButton
        Left = 32
        Top = 24
        Width = 89
        Height = 22
        Caption = 'arc +'
        OnClick = SpeedButton3Click
      end
      object SpeedButton4: TSpeedButton
        Left = 32
        Top = 48
        Width = 89
        Height = 25
        Caption = 'arc -'
        OnClick = SpeedButton4Click
      end
      object SpeedButton5: TSpeedButton
        Left = 144
        Top = 32
        Width = 57
        Height = 22
        AllowAllUp = True
        GroupIndex = 12
        Caption = 'RADIATE'
        OnClick = SpeedButton5Click
      end
      object SpeedButton6: TSpeedButton
        Left = 40
        Top = 80
        Width = 57
        Height = 22
        AllowAllUp = True
        GroupIndex = 13
        Down = True
        Caption = 'Timebase '
        OnClick = SpeedButton6Click
      end
      object SpeedButton7: TSpeedButton
        Left = 40
        Top = 112
        Width = 57
        Height = 22
        AllowAllUp = True
        GroupIndex = 14
        Down = True
        Caption = 'BackGround'
        OnClick = SpeedButton7Click
      end
      object SpeedButton8: TSpeedButton
        Left = 152
        Top = 72
        Width = 41
        Height = 41
        Caption = 'Q'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'TDCCursor'
        Font.Style = []
        ParentFont = False
      end
    end
  end
end
