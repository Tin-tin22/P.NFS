unit uManageLoadDraw;

interface

uses Windows, MapXLib_TLB;

type
  TManageLoadDraw = class

  public
    FLyrDraw : CMapXLayer;

    procedure loadMap(fMap: TMap);
    procedure loadBlankMap(fMap: TMap; backScreen : String);
  end;

implementation

procedure InitOleVariant(var TheVar: OleVariant);
begin
  TVarData(TheVar).vType := varError;
  TVarData(TheVar).vError := DISP_E_PARAMNOTFOUND;
end;

procedure TManageLoadDraw.loadMap(fMap: TMap);
var
   backscreen  : string;
   fileSetting : TextFile;
begin
   AssignFile(fileSetting, 'yakhont_setting.ini');
   Reset(fileSetting);

   while not Eof(fileSetting) do
   begin
     ReadLn(fileSetting, backscreen);
   end;

   CloseFile(fileSetting);
   loadBlankMap(fMap, backscreen);
end;

procedure TManageLoadDraw.loadBlankMap(fMap : TMap; backscreen : string);
var
  i: Integer;
  z: OleVariant;
  mInfo: CMapXLayerInfo;
begin
  if fMap = nil then
    Exit;
  InitOleVariant(z);
  fMap.Layers.RemoveAll;

  fMap.Geoset := backscreen;

  if backscreen <> '' then
  begin
    for i := 1 to fMap.Layers.Count do
    begin
      fMap.Layers.Item(i).Selectable := false;
      fMap.Layers.Item(i).Editable  := False;
    end;

    mInfo := CoLayerInfo.Create;
    mInfo.type_ := miLayerInfoTypeUserDraw;
    mInfo.AddParameter('Name', 'LYR_DRAW');
    FLyrDraw := fMap.Layers.Add(mInfo, 1);

    fMap.Layers.AnimationLayer := FLyrDraw;
    fMap.MapUnit := miUnitNauticalMile;
  end;
//  fMap.BackColor := RGB(192, 224, 255);
end;

end.
