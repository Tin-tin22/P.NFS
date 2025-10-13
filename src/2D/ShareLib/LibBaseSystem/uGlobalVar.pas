unit uGlobalVar;

interface

uses
  Classes ;

const
  C_SERVER3D_CLOSE    = 0 ;
  C_SERVER3D_STOP     = 1 ;
  C_SERVER3D_IDLE     = 2 ;
  C_SERVER3D_RUNNING  = 3 ;
var
  CurrentScenarioID   : Integer ;
  IDGame              : Integer; // buat IDGame waktu play scenario lagi
  GameName            : string;
  CurrentScenarioName : String ;
  CurrentLogFile      : String ;
  Server3DIsOnline    : integer ;
  SceIDTemporary      : integer; //buat nyimpen CurrentScenarioID sebelum di nolkan *andik
  
implementation

end.
