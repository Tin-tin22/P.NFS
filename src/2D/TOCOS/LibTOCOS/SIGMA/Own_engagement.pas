unit Own_engagement;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, VrControls, VrButtons, ExtCtrls;

type
  TFrmOwn_engagement = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    VrDemoButton1: TVrDemoButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ListBox1: TListBox;
    VrDemoButton2: TVrDemoButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmOwn_engagement: TFrmOwn_engagement;

implementation

{$R *.dfm}

end.
