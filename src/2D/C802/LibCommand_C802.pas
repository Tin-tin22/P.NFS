unit LibCommand_C802;

interface

uses
  uTCPDatatype;

type

  //record untuk mengirim command;
  RecCMD_C802 = record
    pc  : TPacketCheck;
    cmd : Integer;
  end;

const
  Rec_Cmd = 802;

  CMD_C802_Combat = 1;
  CMD_C802_Simulate = 2;
  CMD_C802_Check = 3;
  CMD_C802_LogOff = 4;
  CMD_C802_Status = 5;
  CMD_C802_MControl = 6;
  CMD_C802_ParSetting = 7;
  CMD_C802_RecordData = 8;

  CMD_C802_Tab = 9;
  CMD_C802_Esc = 10;
  CMD_C802_BackSpace = 11;
  CMD_C802_Enter = 13;

  CMD_C802_OnOff = 14;
//  CMD_C802_Off = 15;

  CMD_C802_Up = 16;
  CMD_C802_Down = 17;
  CMD_C802_Left = 18;
  CMD_C802_Right = 19;

  CMD_C802_Dash = 20;
  CMD_C802_Dot = 21;

  CMD_C802_1 = 22;
  CMD_C802_2 = 23;
  CMD_C802_3 = 24;
  CMD_C802_4 = 25;
  CMD_C802_5 = 26;
  CMD_C802_6 = 27;
  CMD_C802_7 = 28;
  CMD_C802_8 = 29;
  CMD_C802_9 = 30;
  CMD_C802_0 = 31;

implementation

end.
