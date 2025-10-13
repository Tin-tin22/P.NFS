unit ufEventLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, AdvListV, AdvPageControl,

  uClassDatabase,
  uDataModule;

type
  TfrmEventLog = class(TForm)
    AdvEventLog: TAdvPageControl;
    tabTOCOS: TAdvTabSheet;
    lvCommandTocos: TAdvListView;
    tabC802: TAdvTabSheet;
    lvCommandC802: TAdvListView;
    tabYakhont: TAdvTabSheet;
    lvCommandYakhont: TAdvListView;
    tabRBU: TAdvTabSheet;
    lvCommandRBU: TAdvListView;
    tabASROC: TAdvTabSheet;
    lvCommandAsroc: TAdvListView;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetMessage(LogEvent: TLogEvent; IDConsole,IDEvent: Integer):string;
    procedure InsertEventlog(LogEvent : TLogEvent);
    procedure ShowTab(value : Integer);
  end;

var
  frmEventLog: TfrmEventLog;

implementation

{$R *.dfm}

{ TfrmEventLog }

function TfrmEventLog.GetMessage(LogEvent: TLogEvent; IDConsole, IDEvent: Integer): string;
var
  MessageTemp, MessageEvent : string;
begin
  MessageTemp   := DataModule1.GetMessageFromEventID(LogEvent.ConsoleID,LogEvent.EventID);
  MessageEvent  := StringReplace(MessageTemp, '<1>', FloatToStr(LogEvent.Param1),
                          [rfReplaceAll, rfIgnoreCase]);
  MessageEvent  := StringReplace(MessageEvent, '<2>', FloatToStr(LogEvent.Param2),
                          [rfReplaceAll, rfIgnoreCase]);
  MessageEvent  := StringReplace(MessageEvent, '<3>', FloatToStr(LogEvent.Param3),
                          [rfReplaceAll, rfIgnoreCase]);
  result := MessageEvent;
end;

procedure TfrmEventLog.FormCreate(Sender: TObject);
begin
    lvCommandAsroc.Columns[0].Width := 270;
    lvCommandAsroc.Columns[1].Width := 270;
    lvCommandAsroc.Columns[2].Width := 270;
    lvCommandAsroc.Columns[3].Width := 346;
    lvCommandAsroc.Columns[4].Width := 270;

    lvCommandRBU.Columns[0].Width := 270;
    lvCommandRBU.Columns[1].Width := 270;
    lvCommandRBU.Columns[2].Width := 270;
    lvCommandRBU.Columns[3].Width := 346;
    lvCommandRBU.Columns[4].Width := 270;

    lvCommandTocos.Columns[0].Width := 270;
    lvCommandTocos.Columns[1].Width := 270;
    lvCommandTocos.Columns[2].Width := 270;
    lvCommandTocos.Columns[3].Width := 346;
    lvCommandTocos.Columns[4].Width := 270;

    lvCommandYakhont.Columns[0].Width := 270;
    lvCommandYakhont.Columns[1].Width := 270;
    lvCommandYakhont.Columns[2].Width := 270;
    lvCommandYakhont.Columns[3].Width := 346;
    lvCommandYakhont.Columns[4].Width := 270;

    lvCommandC802.Columns[0].Width := 270;
    lvCommandC802.Columns[1].Width := 270;
    lvCommandC802.Columns[2].Width := 270;
    lvCommandC802.Columns[3].Width := 346;
    lvCommandC802.Columns[4].Width := 270;

end; 

procedure TfrmEventLog.InsertEventlog(LogEvent: TLogEvent);
var
   li : TListItem;
   ScenarioName, MessageClient, ShipName : string;
begin
  if LogEvent.ConsoleID = 1 then       //ASROC
  begin
    ScenarioName  := DataModule1.GetScenarioByID(LogEvent.ScenarioID);
    MessageClient := GetMessage(LogEvent,LogEvent.ConsoleID,LogEvent.EventID);
    ShipName      := DataModule1.GetShipNameByID(LogEvent.ShipID);

    li := lvCommandAsroc.Items.Add;
    li.Caption := ScenarioName;
    li.SubItems.Add(IntToStr(LogEvent.GameID));
    li.SubItems.Add(ShipName);
    li.SubItems.Add(MessageClient);
    li.SubItems.Add(LogEvent.tanggal +' '+LogEvent.jam );

    ShowTab(LogEvent.ConsoleID);
  end
  else if LogEvent.ConsoleID = 2 then   //RBU6000
  begin

  end
  else if LogEvent.ConsoleID = 3 then  //TORPEDO_A244S
  begin

  end
  else if LogEvent.ConsoleID = 4 then   //TORPEDO_SUT
  begin

  end
  else if LogEvent.ConsoleID = 5 then    //TETRAL
  begin

  end
  else if LogEvent.ConsoleID = 6 then     //YAKHONT
  begin
    ScenarioName  := DataModule1.GetScenarioByID(LogEvent.ScenarioID);
    MessageClient := GetMessage(LogEvent,LogEvent.ConsoleID,LogEvent.EventID);
    ShipName      := DataModule1.GetShipNameByID(LogEvent.ShipID);

    li := lvCommandYakhont.Items.Add;
    li.Caption := ScenarioName;
    li.SubItems.Add(IntToStr(LogEvent.GameID));
    li.SubItems.Add(ShipName);
    li.SubItems.Add(MessageClient);
    li.SubItems.Add(LogEvent.tanggal+' '+LogEvent.jam);

    ShowTab(LogEvent.ConsoleID);
  end
  else if LogEvent.ConsoleID = 7 then     //C802
  begin

  end
  else if LogEvent.ConsoleID = 8 then      //MISTRAL
  begin

  end
  else if LogEvent.ConsoleID = 9 then      //STRELA
  begin

  end
  else if LogEvent.ConsoleID = 10 then     //EXOCET_MM40
  begin

  end
  else if LogEvent.ConsoleID = 11 then      //EXOCET_MM38
  begin

  end
  else if LogEvent.ConsoleID = 12 then       //CANNON40
  begin

  end
  else if LogEvent.ConsoleID = 13 then     //CANNON57
  begin

  end
  else if LogEvent.ConsoleID = 14 then     //CANNON76
  begin

  end
  else if LogEvent.ConsoleID = 15 then     //CANNON120
  begin

  end;

end;

procedure TfrmEventLog.ShowTab(value: Integer);
begin
  if value = 1 then                          //ASROC
  begin
    lvCommandAsroc.Columns[0].Width := 270;
    lvCommandAsroc.Columns[1].Width := 270;
    lvCommandAsroc.Columns[2].Width := 270;
    lvCommandAsroc.Columns[3].Width := 346;
    lvCommandAsroc.Columns[4].Width := 270;
    tabASROC.Show;
  end
  else if value = 2 then                     //RBU6000
  begin
    lvCommandRBU.Columns[0].Width := 270;
    lvCommandRBU.Columns[1].Width := 270;
    lvCommandRBU.Columns[2].Width := 270;
    lvCommandRBU.Columns[3].Width := 346;
    lvCommandRBU.Columns[4].Width := 270;
    tabRBU.Show;
  end
  else if value = 3 then                    //TORPEDO_A244S
  begin

  end
  else if value = 4 then                    //TORPEDO_SUT
  begin
    lvCommandTocos.Columns[0].Width := 270;
    lvCommandTocos.Columns[1].Width := 270;
    lvCommandTocos.Columns[2].Width := 270;
    lvCommandTocos.Columns[3].Width := 346;
    lvCommandTocos.Columns[4].Width := 270;
    tabTOCOS.Show;
  end
  else if value = 5 then                   //TETRAL
  begin

  end
  else if value = 6 then                  //YAKHONT
  begin
    lvCommandYakhont.Columns[0].Width := 270;
    lvCommandYakhont.Columns[1].Width := 270;
    lvCommandYakhont.Columns[2].Width := 270;
    lvCommandYakhont.Columns[3].Width := 346;
    lvCommandYakhont.Columns[4].Width := 270;
    tabYakhont.Show;
  end
  else if value = 7 then                   //C802
  begin
    lvCommandC802.Columns[0].Width := 270;
    lvCommandC802.Columns[1].Width := 270;
    lvCommandC802.Columns[2].Width := 270;
    lvCommandC802.Columns[3].Width := 346;
    lvCommandC802.Columns[4].Width := 270;
    tabC802.Show;
  end
  else if value = 8 then                   //MISTRAL
  begin

  end
  else if value = 9 then                   //STRELA
  begin

  end
  else if value = 10 then                 //EXOCET_MM40
  begin

  end
  else if value = 11 then                 //EXOCET_MM38
  begin

  end
  else if value = 12 then                 //CANNON40
  begin

  end
  else if value = 13 then                //CANNON57
  begin

  end
  else if value = 14 then                 //CANNON76
  begin

  end
  else if value = 15 then                 //CANNON120
  begin
    
  end;
end;

end.
