object DM: TDM
  OldCreateOrder = False
  Height = 184
  Width = 237
  object DQ: TZQuery
    Params = <>
    Left = 88
    Top = 25
  end
  object DS: TZQuery
    Connection = EmuConn
    Params = <>
    Left = 136
    Top = 25
  end
  object EmuConn: TZConnection
    Protocol = 'mysql-5'
    HostName = '192.168.1.141'
    Port = 3306
    Database = 'dbNSuFs'
    User = 'usrNSUFS'
    Password = 'admin'
    Left = 32
    Top = 96
  end
end
