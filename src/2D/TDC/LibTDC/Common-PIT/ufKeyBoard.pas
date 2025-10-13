unit ufKeyBoard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufQEK, ImgList, ufANDUDisplay, Buttons, SpeedButtonImage, ExtCtrls;

type

  TfrmKeyBoard = class(TfrmQEK)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

  protected
    Mnemonic : string;
    LastMnemonic : string;

    procedure key_AlphaNum(const key: Char);
    procedure key_BackSpace(const key: Char);
    procedure key_Execute(const key: Char);
    procedure key_EraseLine(const key: Char);
    procedure key_Space(const key: Char);
    procedure key_lastexect(const key: Char);

    procedure btn_AlphaNumClick(Sender: TObject);
    procedure btn_BackSpaceClick(Sender: TObject);
    procedure btn_4spaceClick(Sender: TObject);
    procedure btn_ExecuteClick(Sender: TObject);
    procedure btn_EraseLineClick(Sender: TObject);


  public
    { Public declarations }
    Display : TfrmANDUDisplay;
    PositionID: byte;         // kiri = 0, kanan = 1; 

    function  ParseCommand(const str: string): integer; virtual;

    procedure handle_execute(const str: string);
    procedure LoadScript(const fName: string);

  end;

var
  frmKeyBoard: TfrmKeyBoard;

implementation

{$R *.dfm}

procedure TfrmKeyBoard.key_AlphaNum(const key: Char);
begin
  Mnemonic := Mnemonic + key;
end;

procedure TfrmKeyBoard.key_BackSpace(const key: Char);
begin
  SetLength(Mnemonic, Length(Mnemonic)-1);
end;

procedure TfrmKeyBoard.key_Execute(const key: Char);
var ret : integer;
begin
  ret := ParseCommand(Mnemonic);
  if ret >= 0 then begin
    LastMnemonic := Mnemonic;
    Mnemonic := '';
  end;
end;

procedure TfrmKeyBoard.key_EraseLine(const key: Char);
begin
  Mnemonic := '';
end;

procedure TfrmKeyBoard.key_Space(const key: Char);
begin
  Mnemonic := Mnemonic + ' ';
end;

procedure TfrmKeyBoard.key_lastexect(const key: Char);
begin
  Mnemonic := LastMnemonic;
end;


procedure TfrmKeyBoard.handle_execute(const str: string);
begin
  if ParseCommand(str) > 0 then
    Display.SetICLText('');
end;


function TfrmKeyBoard.ParseCommand(const str: string): integer;
begin

end;

procedure TfrmKeyBoard.LoadScript(const fName: string);
var i, ret: integer;
    ss: TStrings;
    s : string;
begin
  if not FileExists(fName) then begin
//    Display.SetTextLine(16, 'filenya ga ada.');
    exit;
  end;

  ss := TStringList.Create;
  ss.LoadFromFile(fName);

  i := 0;
  while (i < ss.Count) do begin
    s := UpperCase(ss[i]);
    ret := ParseCommand(s);

    inc(i);
  end;

  ss.Destroy;
end;

procedure TfrmKeyBoard.btn_AlphaNumClick(Sender: TObject);
begin
  Mnemonic := Mnemonic + char( byte((sender as TComponent).Tag));
  Display.SetICLText(Mnemonic);
end;

procedure TfrmKeyBoard.btn_BackSpaceClick(Sender: TObject);
begin
  SetLength(Mnemonic, Length(Mnemonic)-1);
  Display.SetICLText(Mnemonic);
end;


procedure TfrmKeyBoard.btn_4spaceClick(Sender: TObject);
begin
  Mnemonic := Mnemonic + '   ';
  Display.SetICLText(Mnemonic);
end;

procedure TfrmKeyBoard.btn_ExecuteClick(Sender: TObject);
begin
//  Action_Mnemonic(Mnemonic);
  ParseCommand(Mnemonic);
  Mnemonic := '';
  Display.SetICLText(Mnemonic);
end;

procedure TfrmKeyBoard.btn_EraseLineClick(Sender: TObject);
begin
  Mnemonic := '';
  Display.SetICLText(Mnemonic);
end;



procedure TfrmKeyBoard.FormCreate(Sender: TObject);
begin
//  inherited;

end;

end.
