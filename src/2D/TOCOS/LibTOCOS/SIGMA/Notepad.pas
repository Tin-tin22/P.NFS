unit Notepad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, VrControls, VrButtons, ExtCtrls;

type
  TFrmNotepad = class(TForm)
    Panel1: TPanel;
    VrDemoButton6: TVrDemoButton;
    ListBox1: TListBox;
    VrDemoButton1: TVrDemoButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmNotepad: TFrmNotepad;

implementation

{$R *.dfm}

end.
