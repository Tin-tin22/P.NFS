object frmMain: TfrmMain
  Left = 40
  Top = 509
  Width = 398
  Height = 240
  Caption = 'frmMain'
  Color = clWhite
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 390
    Height = 213
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel3'
    TabOrder = 0
    object pcMainMenu: TPageControl
      Left = 0
      Top = 0
      Width = 390
      Height = 213
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      object tsMultiplayer: TTabSheet
        Caption = '&Multiplayer'
        ImageIndex = 2
        object pnlMultiplayer: TPanel
          Left = 0
          Top = 0
          Width = 382
          Height = 185
          Align = alClient
          BevelOuter = bvLowered
          TabOrder = 0
          object spbMultiPlayNext: TSpeedButton
            Left = 280
            Top = 152
            Width = 89
            Height = 22
            Caption = 'Next'
            OnClick = spbMultiPlayNextClick
          end
          object Label4: TLabel
            Left = 16
            Top = 8
            Width = 175
            Height = 20
            Caption = 'Stand Alone / Multiplayer'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsUnderline]
            ParentFont = False
            Transparent = True
          end
          object Memo1: TMemo
            Left = 128
            Top = 40
            Width = 241
            Height = 105
            Ctl3D = False
            ParentCtl3D = False
            TabOrder = 0
          end
          object rgMultiplayOption: TRadioGroup
            Left = 8
            Top = 40
            Width = 105
            Height = 105
            Caption = 'Select'
            Ctl3D = False
            ItemIndex = 0
            Items.Strings = (
              'Stand Alone'
              'Publisher'
              'Subscriber')
            ParentCtl3D = False
            TabOrder = 1
            OnClick = rgMultiplayOptionClick
          end
        end
      end
      object tsInitialize: TTabSheet
        Caption = '&Initialize'
        object pnlInit: TPanel
          Left = 0
          Top = 0
          Width = 382
          Height = 185
          Align = alClient
          BevelOuter = bvLowered
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 0
          object spbInitSelectScene: TSpeedButton
            Left = 16
            Top = 48
            Width = 65
            Height = 33
            Caption = 'Select Scen'
            OnClick = spbInitSelectSceneClick
          end
          object spbInit: TSpeedButton
            Left = 16
            Top = 96
            Width = 65
            Height = 33
            OnClick = spbInitClick
          end
          object spbInitSceneNext: TSpeedButton
            Left = 280
            Top = 152
            Width = 81
            Height = 22
            Caption = 'Next'
            OnClick = spbInitSceneNextClick
          end
          object spbInitSceneBack: TSpeedButton
            Left = 184
            Top = 152
            Width = 81
            Height = 22
            Caption = 'Back'
            OnClick = spbInitSceneBackClick
          end
          object Label3: TLabel
            Left = 16
            Top = 8
            Width = 63
            Height = 20
            Caption = 'Scenario'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsUnderline]
            ParentFont = False
            Transparent = True
          end
          object Memo2: TMemo
            Left = 128
            Top = 40
            Width = 241
            Height = 105
            Ctl3D = False
            Lines.Strings = (
              'Selected Scenario Description')
            ParentCtl3D = False
            TabOrder = 0
          end
        end
      end
      object tsSimulation: TTabSheet
        Caption = '&Simulation'
        ImageIndex = 1
        object pnlSimCtrl: TPanel
          Left = 0
          Top = 0
          Width = 382
          Height = 185
          Align = alClient
          BevelInner = bvLowered
          BevelOuter = bvNone
          Enabled = False
          TabOrder = 0
          object Label1: TLabel
            Left = 16
            Top = 8
            Width = 129
            Height = 20
            Caption = 'Simulation Control'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsUnderline]
            ParentFont = False
            Transparent = True
          end
          object spbSimRestart: TSpeedButton
            Left = 280
            Top = 152
            Width = 81
            Height = 22
            Caption = 'Restart'
            OnClick = spbSimRestartClick
          end
          object Label5: TLabel
            Left = 16
            Top = 144
            Width = 51
            Height = 13
            Caption = 'Game Play'
          end
          object lblGamePlay: TLabel
            Left = 88
            Top = 144
            Width = 3
            Height = 13
          end
          object Panel1: TPanel
            Left = 152
            Top = 88
            Width = 209
            Height = 41
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object shpPlayingStatus: TShape
              Left = 5
              Top = 11
              Width = 36
              Height = 21
              Brush.Color = clGreen
              Pen.Color = clLime
              Shape = stEllipse
            end
            object Label2: TLabel
              Left = 12
              Top = 15
              Width = 20
              Height = 13
              Caption = 'Play'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clYellow
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              Transparent = True
            end
            object pnlPlay: TPanel
              Left = 48
              Top = 5
              Width = 73
              Height = 31
              BevelOuter = bvNone
              TabOrder = 0
              object spbPlay: TSpeedButton
                Left = 4
                Top = 3
                Width = 33
                Height = 27
                GroupIndex = 1
                Caption = 'Play'
                Flat = True
                OnClick = spbPlayClick
              end
              object spbStop: TSpeedButton
                Left = 36
                Top = 3
                Width = 33
                Height = 27
                GroupIndex = 1
                Down = True
                Caption = 'Stop'
                Flat = True
                OnClick = spbStopClick
              end
            end
            object pnlPause: TPanel
              Left = 121
              Top = 5
              Width = 73
              Height = 31
              BevelOuter = bvNone
              Enabled = False
              TabOrder = 1
              object spbPause: TSpeedButton
                Left = 3
                Top = 4
                Width = 33
                Height = 27
                GroupIndex = 2
                Caption = 'Pause'
                Flat = True
                OnClick = spbPauseClick
              end
              object spbResume: TSpeedButton
                Left = 35
                Top = 4
                Width = 33
                Height = 27
                GroupIndex = 2
                Down = True
                Caption = 'Resume'
                Flat = True
                OnClick = spbResumeClick
              end
            end
          end
          object rgSimSpeed: TRadioGroup
            Left = 16
            Top = 80
            Width = 113
            Height = 57
            Caption = 'Speed'
            Columns = 2
            ItemIndex = 0
            Items.Strings = (
              '1'
              '2'
              '4'
              '8'
              '60')
            TabOrder = 1
            OnClick = rgSimSpeedClick
          end
          object ScrollBar1: TScrollBar
            Left = 16
            Top = 48
            Width = 345
            Height = 16
            PageSize = 0
            TabOrder = 2
          end
        end
      end
      object tsInfo: TTabSheet
        Caption = '&About'
        ImageIndex = 3
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 382
          Height = 185
          Align = alClient
          BevelOuter = bvLowered
          TabOrder = 0
        end
      end
      object tsLog: TTabSheet
        Caption = 'LogStatus'
        ImageIndex = 4
        object RichEdit1: TRichEdit
          Left = 121
          Top = 0
          Width = 261
          Height = 185
          Align = alClient
          Lines.Strings = (
            '12:00:00 - Simulation started as publisher.'
            'Selected Scenario :  '#39'GCI 2006 on Balikpapan'#39
            ''
            '12:00:02 - '#39'siswa 1'#39' join the game from meja 12'
            '12:00:03 - launch hawk 200 from balikpapan')
          TabOrder = 0
        end
        object lbx: TListBox
          Left = 0
          Top = 0
          Width = 121
          Height = 185
          Align = alLeft
          ItemHeight = 13
          TabOrder = 1
        end
      end
      object TabSheet1: TTabSheet
        Caption = 'TabSheet1'
        ImageIndex = 5
        object Button1: TButton
          Left = 24
          Top = 64
          Width = 75
          Height = 25
          Caption = 'Map'
          TabOrder = 0
          OnClick = Button1Click
        end
        object btnRemove: TButton
          Left = 24
          Top = 136
          Width = 75
          Height = 25
          Caption = 'Remove 50'
          TabOrder = 1
          OnClick = btnRemoveClick
        end
        object btnAdd: TButton
          Left = 24
          Top = 112
          Width = 75
          Height = 25
          Caption = 'Add 50'
          TabOrder = 2
          OnClick = btnAddClick
        end
        object Edit1: TEdit
          Left = 128
          Top = 120
          Width = 121
          Height = 21
          TabOrder = 3
          Text = 'Edit1'
        end
        object Button2: TButton
          Left = 32
          Top = 16
          Width = 49
          Height = 25
          Caption = 'Arrow'
          TabOrder = 4
          OnClick = Button2Click
        end
        object Button3: TButton
          Left = 80
          Top = 16
          Width = 57
          Height = 25
          Caption = 'ZoomIn'
          TabOrder = 5
          OnClick = Button3Click
        end
        object Button4: TButton
          Left = 136
          Top = 16
          Width = 75
          Height = 25
          Caption = 'ZoomOut'
          TabOrder = 6
          OnClick = Button4Click
        end
      end
    end
  end
  object tmrStatus: TTimer
    Enabled = False
    OnTimer = tmrStatusTimer
    Left = 328
    Top = 32
  end
  object XPManifest1: TXPManifest
    Left = 252
    Top = 40
  end
end
