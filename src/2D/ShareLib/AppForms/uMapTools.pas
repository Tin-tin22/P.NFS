unit uMapTools;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MapXLib_TLB, ComCtrls, ToolWin;

type
  TfrmMapTools = class(TForm)
    tlbStdMapMenu: TToolBar;
    tbtnArrow: TToolButton;
    tbtnZoomIn: TToolButton;
    tbtnZoomOut: TToolButton;
    tbtnPan: TToolButton;
    tbtnCenter: TToolButton;
    ToolButton7: TToolButton;
    tbtnDistance: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure tbtnArrowClick(Sender: TObject);
    procedure tbtnDistanceClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Map : TMap;
  end;

var
  frmMapTools: TfrmMapTools;

implementation

{$R *.dfm}



procedure TfrmMapTools.FormCreate(Sender: TObject);
begin
  tbtnArrow.tag     :=  miArrowTool   ;
  tbtnZoomIn.tag    :=  miZoomInTool  ;
  tbtnZoomOut.tag   :=  miZoomOutTool ;
  tbtnPan.tag       :=  miPanTool     ;
  tbtnCenter.tag    :=  miCenterTool  ;

end;

procedure TfrmMapTools.tbtnArrowClick(Sender: TObject);
begin
  Map.CurrentTool := (sender as TComponent).Tag;
end;

procedure TfrmMapTools.tbtnDistanceClick(Sender: TObject);
const
  TOOL_RANGE_BEARING = 01;
begin
  map.CurrentTool := TOOL_RANGE_BEARING;
end;

end.
