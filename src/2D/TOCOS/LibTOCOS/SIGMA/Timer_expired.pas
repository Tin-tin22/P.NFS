unit Timer_expired;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VrControls, VrButtons, ExtCtrls, StdCtrls;

type
  TFrmTimer_expired = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    VrDemoButton1: TVrDemoButton;
    Label2: TLabel;
    Label3: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTimer_expired: TFrmTimer_expired;

implementation

{$R *.dfm}

end.
