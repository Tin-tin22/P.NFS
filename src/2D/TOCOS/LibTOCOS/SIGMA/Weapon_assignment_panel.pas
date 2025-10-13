unit Weapon_assignment_panel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, VrButtons, VrControls, StdCtrls;

type
  TFrmWeapon_assign_panel = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    ComboBox1: TComboBox;
    VrDemoButton1: TVrDemoButton;
    VrPowerButton1: TVrPowerButton;
    Label2: TLabel;
    Bevel1: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    VrPowerButton2: TVrPowerButton;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label7: TLabel;
    VrDemoButton2: TVrDemoButton;
    VrDemoButton3: TVrDemoButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmWeapon_assign_panel: TFrmWeapon_assign_panel;

implementation

{$R *.dfm}

end.
