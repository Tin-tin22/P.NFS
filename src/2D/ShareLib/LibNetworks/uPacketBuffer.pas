unit uPacketBuffer;

interface

uses
  Classes, SysUtils, uTCPDatatype;

type

  //Edited By Nando For NFS
  TLocBuff = Class
    aSize : Word;
    pLocBuff : PAnsiChar;
  End;

  TPacketBuffer = class
  private
    function GetCount: integer;
  protected
    FBuff    : TThreadList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;

    procedure PutPacket(p: PAnsiChar; const aSize: Word);
    function PeekPacket(const i: integer; var p: PAnsiChar; var aSize: Word): boolean;
    property BuffCount: integer read GetCount;

  end;

implementation

uses
   Windows;


{ TPacketBuffer }
constructor TPacketBuffer.Create;
begin
  FBuff := TThreadList.Create;
end;

destructor TPacketBuffer.Destroy;
begin
  Clear;

  FBuff.Free;
  inherited;
end;

procedure TPacketBuffer.Clear;
var i: integer;
begin
  with FBuff.LockList do
  for i := Count-1 downto 0  do begin
    FreeMem(Items[i]);
    Delete(i);
  end;
  FBuff.UnlockList;
end;

function TPacketBuffer.GetCount: integer;
begin
  Result := FBuff.LockList.Count;
  FBuff.UnlockList;
end;

procedure TPacketBuffer.PutPacket(p: PAnsiChar; const aSize: Word);
var pid: ^TPacketCheck;
    l : TList;
    LocBuff : TLocBuff;
begin // cause we want to make 'put' faster, we put new quee at the end of list.
  if aSize < SizeOf(TPacketCheck) then Exit;

  l := FBuff.LockList;
  try
    LocBuff := TLocBuff.Create;

    GetMem(LocBuff.pLocBuff, aSize);
    CopyMemory(LocBuff.pLocBuff, p,  aSize);
    LocBuff.aSize := aSize;

    l.Add(LocBuff);
  finally
    FBuff.UnlockList;
  end;
end;

function TPacketBuffer.PeekPacket(const i: integer; var p: PAnsiChar; var aSize: Word): boolean;
var pid: ^TPacketCheck;
begin
  with FBuff.LockList do begin
    result := (i >=0) and (i < Count);

    if result then begin
      p  	:= TLocBuff(Items[i]).pLocBuff;
      aSize := TLocBuff(Items[i]).aSize;
    end;
  end;
  FBuff.UnlockList;
end;

end.
