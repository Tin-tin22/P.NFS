unit ufLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls;

type
  TfrmLog = class(TForm)
    ListBox1: TListBox;
    Panel1: TPanel;
    StatusBar1: TStatusBar;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddLog(const s: string);
  end;

var
  frmLog: TfrmLog;

implementation

{$R *.dfm}

{ TfrmLog }

procedure TfrmLog.AddLog(const s: string);
begin
  ListBox1.Items.Add(s);
end;

end.
