unit Logger;

interface

uses SysUtils;

type

  TLogFile = class
    private
      fFilename: string;
      fisLog: Boolean;
      fLogFile:TextFile;
    public
      constructor Create;
      destructor Destroy; override;
      procedure Init;
      procedure Log(ASection, AMsg: string);
      procedure Close;
    published
      property FileName: string read fFilename write fFilename;
      property IsLog: Boolean read fisLog write fisLog;
  end;

implementation

constructor TLogFile.Create;
begin
  inherited Create;
end;

destructor TLogFile.Destroy;
begin
  Close;
  inherited Destroy;
end;

procedure TLogFile.Init;
begin
  if not fisLog then
    CloseFile(fLogFile)
  else begin
    try
      AssignFile(fLogFile,fFilename);
      Rewrite(fLogFile);
    except
      on e:Exception do
        CloseFile(fLogFile);
    end;
  end;
end;

procedure TLogFile.Log(ASection, AMsg: string);
begin
  if fisLog then
    WriteLn(fLogFile, '['+FormatDateTime('dd mmm yyyy hh:nn:ss',Now)+ '] <'+ASection+'> '+AMsg);
end;

procedure TLogFile.Close;
begin
  CloseFile(fLogFile);
end;

end.
