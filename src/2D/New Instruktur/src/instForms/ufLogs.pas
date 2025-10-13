unit ufLogs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls ;

type
  TfrmLogs = class(TForm)
    mmLog: TMemo;
    netLogClient: TMemo;
    netLogServer: TMemo;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogs: TfrmLogs;

implementation

{$R *.dfm}

procedure TfrmLogs.FormCreate(Sender: TObject);
begin
 // Show;
end;

end.
