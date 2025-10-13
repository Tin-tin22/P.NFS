unit uConnect;

interface

uses SysUtils, Dialogs, IniFiles;

type
  TConf_AutoConfig = class
    private

    public
      PathSceID : string;
      FileName : string;

      constructor Create;
      destructor Destroy; override;
      procedure Load;
      procedure Save;
    published
  end;

implementation

{ TConf_AutoConfig }

constructor TConf_AutoConfig.Create;
begin

end;

destructor TConf_AutoConfig.Destroy;
begin

  inherited;
end;

procedure TConf_AutoConfig.Load;
var
  ini: TIniFile;
begin
  ini:= TIniFile.Create(FileName);
  try
    PathSceID   := Trim(ini.ReadString('AUTOCONNECT','ScenarioID','1'));
  finally
    ini.Free;
  end;
end;

procedure TConf_AutoConfig.Save;
var
  ini: TIniFile;
begin
  ini:= TIniFile.Create(FileName);
  try
    ini.WriteString('AUTOCONNECT','ScenarioID',PathSceID);
  finally
    ini.Free;
  end;
end;

end.
