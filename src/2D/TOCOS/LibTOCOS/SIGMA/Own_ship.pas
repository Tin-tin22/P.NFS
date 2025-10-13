unit Own_ship;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VrControls, VrLcd, StdCtrls, VrButtons, ExtCtrls;

type
  TFrmOwn_ship = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    Bevel2: TBevel;
    VrDemoButton5: TVrDemoButton;
    VrDemoButton6: TVrDemoButton;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    VrClock1: TVrClock;
    Label2: TLabel;
    ComboBox2: TComboBox;
    Edit2: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    VrClock2: TVrClock;
    Label8: TLabel;
    Bevel3: TBevel;
    Label9: TLabel;
    ComboBox3: TComboBox;
    Label10: TLabel;
    Edit3: TEdit;
    Label11: TLabel;
    VrClock3: TVrClock;
    Label12: TLabel;
    Edit4: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Label16: TLabel;
    Edit7: TEdit;
    VrDemoButton1: TVrDemoButton;
    VrDemoButton2: TVrDemoButton;
    VrDemoButton3: TVrDemoButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmOwn_ship: TFrmOwn_ship;

implementation

{$R *.dfm}

end.
