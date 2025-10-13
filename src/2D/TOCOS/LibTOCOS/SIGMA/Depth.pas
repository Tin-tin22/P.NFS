unit Depth;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, VrControls, VrButtons, VrLcd, ExtCtrls;

type
  TFrmDepth = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    Label5: TLabel;
    Label2: TLabel;
    VrClock1: TVrClock;
    VrDemoButton5: TVrDemoButton;
    VrDemoButton6: TVrDemoButton;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    Label3: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
