unit uLogMemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmLogMemo = class(TForm)
    pnlMemo: TPanel;
    pnlSetting: TPanel;
    mmoLogMemo: TMemo;
    mmoSetting: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogMemo: TfrmLogMemo;

implementation

{$R *.dfm}

end.
