unit ulibSettings;

interface
uses
  IniFiles, SysUtils, uIniFilesProcs, uCodecBase64;
const
  c_image = 'image';
type
  TPathImageSetting = record
    ImgPath: string;
  end;

  TRecBridgeDB  = record
    mDBServer,
    mDBProto,
    mDBName,
    mDBUser,
    mDBPass,
    mDBPort: string
  end;

  TRecBridgeServer  = record
    m2D_IP,
    m2D_Port,
    m3D_IP,
    m3D_Port,
    mCtrl_IP,
    mCtrl_port : string;
  end;


  function getFileSetting: string;
  function LoadFF_PathImageSetting(const fName: string; var imgSet: TPathImageSetting): boolean;
  procedure Save_PathImageSetting(const fName: string; var imgSet: TPathImageSetting);

  procedure InitDefault_DBConfig(
    const Path: string;
      var mDBServer, mDBProto, mDBName, mDBUser,  mDBPass, mDBPort : string
    );
  procedure SaveDefault_DBConfig(
    const Path: string;
    const mDBServer, mDBProto, mDBName, mDBUser, mDBPass, mDBPort: string
    );
  procedure InitDefault_GameServerConfig(
    const Path: string;
    var m2DServerIP, m2DServerPort,
    m3DServerIP, m3DServerPort: string
    );
  procedure SaveDefault_GameServerConfig(
    const Path: string;
    const m2DServerIP, m2DServerPort,
    m3DServerIP, m3DServerPort: string
    );

const
  defaultServer       = 'localhost';
  default3DServer     = '192.168.0.82';
  defaultServerPort   = '2120';
  default3DServerPort = '5001';

  default2DServerPortConverter = '7001';
  default3DServerPortConverter = '7002';

  defaultDBServer   = '192.168.1.141';
  defaultDBProto    = 'mysql';
  defaultDBName     = 'dbNSuFs';
  defaultDBUser     = 'usrNSUFS';
  defaultDBPassword = 'admin';
  defaultDBPort     = '3306';

  iniSectDBConfig = 'DBCONFIG';
  iniValDBServer  = 'DBSERVER';
  iniValDBProto   = 'DBPROTO';
  iniValDBName    = 'DBNAME';
  iniValDBUser    = 'DBUSER';
  iniValDBpass    = 'DBPASS';
  iniValDBport    = 'DBPORT';

  iniSectConfig      = 'CONFIG';
  iniValServer       = 'SERVER';
  iniVal3DServer     = '3DSERVER';
  iniValServerPort   = 'SERVERPORT';
  iniVal3DServerPort = '3DSERVERPORT';

var
  {global var}
  //loaded setting  FROM FILE

  vSettingFile: string;
  vDbServer : TRecBridgeDB;
  vBridgeServer : TRecBridgeServer;
  vPathImageSetting      : TPathImageSetting;

implementation
  //==============================================================================
  function getFileSetting: string;
  begin
  //  result := ChangeFileExt(ParamStr(0), '.ini');
    result := ExtractFilePath(ParamStr(0)) + 'm57setting.ini';
  end;
  //==============================================================================

  function LoadFF_PathImageSetting(const fName: string; var imgSet: TPathImageSetting): boolean;
  var
    IniF: TIniFile;
    s: string;
  begin
    IniF := TIniFile.Create(fName);
    s := ExtractFilePath(ParamStr(0));

    with imgSet do
    begin
      ImgPath := IncludeTrailingBackslash(s + IniFReadstring(IniF, c_image,
        'imgpath', '.\data\Picture\'));
    end;

    Result := True;
  end;

  procedure Save_PathImageSetting(const fName: string; var imgSet: TPathImageSetting);
  var
    ini: TIniFile;
  begin
    ini := TIniFile.Create(vSettingFile);
    with ini do begin
      WriteString(c_image, 'imgpath', '.\data\Picture\');
    end;
    ini.Free;
  end;

  function ForceReadString(var ini : TIniFile;
  const sSect, sKey, sDefault : string): string;
  begin
    result := ini.ReadString(sSect, sKey, '');
    if result = '' then begin
      result := sDefault;
      ini.WriteString(sSect, sKey, sDefault);
    end;

  end;

  procedure InitDefault_DBConfig(
    const Path: string;
      var mDBServer, mDBProto, mDBName, mDBUser,  mDBPass, mDBPort : string
    );
  var
    ini: TIniFile;
    readIn, readOut, iniF: string;
  begin
    ini := TIniFile.Create(vSettingFile);

    mDBServer := ForceReadString(ini, iniSectDBConfig, iniValDBServer, defaultDBServer);
    mDBProto := ForceReadString(ini, iniSectDBConfig, iniValDBProto, defaultDBProto);

    readIn := Base64Encode(defaultDBName);
    readOut := ForceReadString(ini, iniSectDBConfig, iniValDBName, readIn);
    mDBName := Base64Decode(readOut);

    readIn := Base64Encode(defaultDBUser);
    readOut := ForceReadString(ini, iniSectDBConfig, iniValDBUser, readIn);
    mDBUser := Base64Decode(readOut);

    readIn := Base64Encode(defaultDBPassword);
    readOut := ForceReadString(ini, iniSectDBConfig, iniValDBPass, readIn);
    mDBPass := Base64Decode(readOut);

    mDBPort := ForceReadString(ini, iniSectDBConfig, iniValDBport, defaultDBPort);

    ini.Free;
  end;

  procedure SaveDefault_DBConfig(
    const Path: string;
    const mDBServer, mDBProto, mDBName, mDBUser, mDBPass, mDBPort: string
    );
  var
    ini: TIniFile;
  begin
    ini := TIniFile.Create(vSettingFile);
    with ini do begin
      WriteString(iniSectDBConfig, iniValDBServer, mDBServer);
      WriteString(iniSectDBConfig, iniValDBProto, mDBProto);
      WriteString(iniSectDBConfig, iniValDBName, Base64Encode(mDBName));
      WriteString(iniSectDBConfig, iniValDBUser, Base64Encode(mDBUser));
      WriteString(iniSectDBConfig, iniValDBPass, Base64Encode(mDBPass));
      WriteString(iniSectDBConfig, iniValDBport, mDBPort);
    end;
    ini.Free;
  end;

  procedure InitDefault_GameServerConfig(
    const Path: string;
    var m2DServerIP, m2DServerPort,
    m3DServerIP, m3DServerPort: string
    );
  var
    ini: TIniFile;
  begin
    ini := TIniFile.Create(vSettingFile);

    m2DServerIP := ForceReadString(ini, iniSectConfig, iniValServer, defaultServer);
    m2DServerPort := ForceReadString(ini, iniSectConfig, iniValServerPort, defaultServerPort);
    m3DServerIP := ForceReadString(ini, iniSectConfig, iniVal3DServer, default3DServer);
    m3DServerPort := ForceReadString(ini, iniSectConfig, iniVal3DServerPort, default3DServerPort);

    ini.Free;
  end;

  procedure SaveDefault_GameServerConfig(
    const Path: string;
    const m2DServerIP, m2DServerPort,
    m3DServerIP, m3DServerPort: string
    );
  var
    ini: TIniFile;
    iniF: string;
  begin
    ini := TIniFile.Create(vSettingFile);
    with ini do begin
      WriteString(iniSectConfig, iniValServer, m2DServerIP);
      WriteString(iniSectConfig, iniValServerPort, m2DServerPort);
      WriteString(iniSectConfig, iniVal3DServer, m3DServerIP);
      WriteString(iniSectConfig, iniVal3DServerPort, m3DServerPort);
    end;
    ini.Free;
  end;
end.
