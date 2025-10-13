unit ufInstLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmMainLog = class(TForm)
    mmoLog: TMemo;
    mmoConnection: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMainLog: TfrmMainLog;

implementation

{$R *.dfm}

end.
