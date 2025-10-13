unit uXMLScen;

interface

uses
  Classes, SysUtils, Dialogs, ZDataset;

function GetIDFromSceneName(const sName: string): integer;
procedure GenerateShipXMLScen(const scenarioID: integer; fileSaveName: string; bDebug: boolean);
procedure GenerateOceanXMLScen(const scenarioID: integer; fileSaveName: string; bDebug: boolean);
procedure GenerateDetailXMLScen(const scenarioID: integer; fileSaveName: string; bDebug: boolean);
function GetSceneNameFromID(const id: integer): string;

implementation

uses uDataModule, DB, uQuery, Math;

const
  sp1 = '    ';
  sp2 = '        ';
  sp3 = '            ';
  c_env_sby = 0;
  c_env_jkt = 1;

function GetSceneNameFromID(const id: integer): string;
begin
  with DataModule1 do begin
    DQ.SQL.Clear;
    DQ.SQL.Add('select NAMA from sce_main where ID=' + IntToStr(id));
    DQ.Open;
    Result := DQ.Fields[0].AsString;
    DQ.Close;
  end;
end;

function GetIDFromSceneName(const sName: string): integer;
begin
  with DataModule1 do begin
    DQ.Close;
    DQ.SQL.Clear;
    DQ.SQL.Add('select ID from sce_main where NAMA=' + QuotedStr(sName));
    DQ.Open;
    Result := DQ.Fields[0].AsInteger;
    DQ.Close;
  end;
end;

procedure GenerateShipXMLScen(const scenarioID: integer; fileSaveName: string; bDebug: boolean);
const
  header = '<?xml version="1.0" encoding="UTF-8"?>';
  head_ship_start = '<ships>';
  head_ship_end = '</ships>';
  component_end = '</component>';
  //cCat = '" category="dtcore.Game.Actors.Simulations" catname="KRI">';
  cCat = '" category="dtcore.Game.Actors.Simulations" ';

var
  i, tipe, catID : integer;
  sID, sName, sLambung, cCatName ,sX, sY, sZ, sRot, s1, s2, s3, s4, s5, sctrl_tipe: string;
  dim_l, dim_w, dim_h, max_speed, max_astern, max_steer: string;
  sList: TStringList;
begin

  if bDebug then ShowMessage('Start Generate XML Scenario');

  with DataModule1 do begin
    DGen.Close;
    DGen.SQL.Clear;
    DGen.SQL.Add('SELECT  B.*, A.TRANS_X, A.TRANS_Y, A.TRANS_Z, A.HEADING');
    DGen.SQL.Add('FROM sce_ship A, m_ship B');
    DGen.SQL.Add('WHERE B.SHIP_ID = A.IDSHIP AND A.IDM =:IDM');
    DGen.ParamByName('IDM').AsInteger := scenarioID;
    DGen.Open;
  end;

  sList := TStringList.Create;

  sList.Clear;
  sList.Add(header);
  sList.Add(head_ship_start);
    

  DataModule1.DGen.First;
  for i := 1 to DataModule1.DGen.RecordCount do begin
    sID := DataModule1.DGen.FieldByName('SHIP_ID').AsString;
    sName := DataModule1.DGen.FieldByName('SHIP_NAME').AsString;
    sLambung := DataModule1.DGen.FieldByName('SHIP_NO').AsString;
    sX := FormatFloat('000.000', DataModule1.DGen.FieldByName('TRANS_X').AsFloat);
    sY := FormatFloat('000.000', DataModule1.DGen.FieldByName('TRANS_Y').AsFloat);
    sZ := FormatFloat('000.000', DataModule1.DGen.FieldByName('TRANS_Z').AsFloat);
    sRot := FormatFloat('000.000', DataModule1.DGen.FieldByName('HEADING').AsFloat);

    if DataModule1.DGen.FieldByName('DIM_LENGTH').AsInteger > 0 then
      dim_l := FormatFloat('0', DataModule1.DGen.FieldByName('DIM_LENGTH').AsInteger)
    else
      dim_l := '100';

    if DataModule1.DGen.FieldByName('DIM_WIDTH').AsInteger > 0 then
      dim_w := FormatFloat('0', DataModule1.DGen.FieldByName('DIM_WIDTH').AsInteger)
    else
      dim_w := '4';

    if DataModule1.DGen.FieldByName('DIM_HEIGHT').AsInteger > 0 then
      dim_h := FormatFloat('0', DataModule1.DGen.FieldByName('DIM_HEIGHT').AsInteger)
    else
      dim_h := '4';

    if DataModule1.DGen.FieldByName('SHIP_MAX_SPEED').AsInteger > 0 then
      max_speed := FormatFloat('0', DataModule1.DGen.FieldByName('SHIP_MAX_SPEED').AsInteger)
    else
      max_speed := '24';

    if DataModule1.DGen.FieldByName('SHIP_MAX_SPEED_ASTERN').AsInteger > 0 then
      max_astern := FormatFloat('0', DataModule1.DGen.FieldByName('SHIP_MAX_SPEED_ASTERN').AsInteger)
    else
      max_astern := '-12';

    if DataModule1.DGen.FieldByName('SHIP_RUDDER').AsInteger > 0 then
      max_steer := FormatFloat('0', DataModule1.DGen.FieldByName('SHIP_RUDDER').AsInteger)
    else
      max_steer := '45';

    sctrl_tipe := DataModule1.DGen.FieldByName('SHIP_CTRL_TYPE').AsString;
    catID      := DataModule1.GetShipCategoryID(StrToInt(sID));
    if DataModule1.GetShipCategoryName(catID) = 'SUBMARINE' then
      cCatName := 'catname="SUBMARINE">'
    else
      cCatName := 'catname="KRI">';
   
    s1 := '<component type="ship" id="' + sID + '" name="' + sName + cCat+ cCatName;
    tipe := GetShip3DType(StrToInt(sID));
    if tipe = 1 then
      s2 := '<mesh>KRI/' + sID {sLambung} + '.IVE</mesh>'
    else
      s2 := '<mesh>Civil/' + sName + '.IVE</mesh>';
    s3 := '<translation x="' + sX + '" y="' + sY + '" z="' + sZ + '"/>';
    s4 := '<rotation x="' + sRot + '" y="0" z="0"/>';
    s5 := '<physics control_type="' + sctrl_tipe + '" length="' + dim_l + '" width = "' + dim_w + '" height="' + dim_h + '" max_ahead="' + max_speed + '" max_astern="' + max_astern + '" max_steer="' + max_steer + '" />';

    sList.Add(sp1 + s1);
    sList.Add(sp2 + s2);
    sList.Add(sp2 + s5);
    sList.Add(sp2 + s3);
    sList.Add(sp2 + s4);
    sList.Add(sp1 + component_end);

    DataModule1.DGen.Next;

  end;
  sList.Add(head_ship_end);



  DataModule1.DGen.Close;


  try
     sList.SaveToFile(fileSaveName);
  except
     ShowMessage('Error save File : "'+fileSaveName+'"');
  end;

  sList.Free;
    
  if bDebug then ShowMessage('End Generate XML Scenario');

end;

procedure GenerateOceanXMLScen(const scenarioID: integer; fileSaveName: string; bDebug: boolean);
const
  c_sd = ' = ';
  c_kr = '"';
  ocean_head_start = '<ocean>';
  ocean_head_end = '</ocean>';
  c_ocean_surface = '<oceansurface';
  c_skybox = '<skybox';
  c_lighting = '<lighting';
  c_fog = '<fog';
  c_end = '/>';

var
  i: integer;
  sName, sVal: string;
  sList: TStringList;

  //c_env_peta, { 0 : Surabaya, 1 : Jakarta, 2 : Laut Lepas }
  //c_env_building, { 0 : Active, 1 : Remove }
  //c_env_static_ship, { 0 : Active, 1 : Remove }
  //c_env_buoy, { 0 : Active, 1 : Remove }
  c_env_theme { 0 : SKY CLEAR,1 : SKY DARK,2 : SKY DUSK,3 : SKY FINE, 4 : NIGHT }: integer;

  c_env_wscale, {1e-008}
  c_env_wpeed, {6}
  c_env_wdirx, {1.0}
  c_env_wdiry, {1.0}
  c_env_fog_h {0.0006}: double;

  qSkybox: TZQuery;
begin

  if bDebug then ShowMessage('Start Generate Ocean XML Scenario');

  qSkybox := TZQuery.Create(DataModule1);
  qSkybox.Connection := DataModule1.EmuConn;

  sList := TStringList.Create;

  sList.Clear;
  sList.Add(ocean_head_start);
  sList.Add(sp1 + c_ocean_surface);

  with DataModule1 do begin
    DS.Close;
    DS.SQL.Clear;
    DS.SQL.Add('select * from sce_main where ID=:ID');
    DS.ParamByName('ID').AsInteger := scenarioID;
    DS.Open;
    if not DS.IsEmpty then begin
      sName := DS.FieldbyName('NAMA').AsString;
      //c_env_peta := DS.FieldbyName('ENV_PETA').AsInteger;
      //c_env_building := DS.FieldbyName('ENV_BUILDING').AsInteger;
      //c_env_static_ship := DS.FieldbyName('ENV_SSHIPS').AsInteger;
      //c_env_buoy := DS.FieldbyName('ENV_BUOY').AsInteger;
      c_env_theme := DS.FieldbyName('ENV_THEME').AsInteger;
      c_env_wscale := DS.FieldbyName('ENV_WSCALE').AsFloat;
      c_env_wpeed := DS.FieldbyName('ENV_WSPEED').AsFloat;
      c_env_wdirx := DS.FieldbyName('ENV_WDIR_X').AsFloat;
      c_env_wdiry := DS.FieldbyName('ENV_WDIR_Y').AsFloat;
      c_env_fog_h := DS.FieldbyName('ENV_FOG_H').AsFloat;
      DS.Close;
    end
    else
      ShowMessage('Generate Ocean XML Scenario Error from ID ' + IntToStr(scenarioID));

  end;

  with DataModule1 do begin
    DS.Close;
    DS.SQL.Clear;
    DS.SQL.Add('select * from env_ocean where ID=' + IntToStr(c_env_theme));
    DS.Open;
    if DS.IsEmpty then begin
      DS.Close;
      DS.SQL.Clear;
      DS.SQL.Add('select * from env_ocean where ID=0');
      DS.Open;
    end;
    for i := 2 to DS.FieldCount - 1 do begin
      if DS.Fields[i].FieldName = 'wind_direction' then
        sVal := DS.Fields[i].FieldName + c_sd + '"' + FormatFloat('0.0', c_env_wdirx) + ',' + FormatFloat('0.0', c_env_wdiry) + '"'
      else
        if DS.Fields[i].FieldName = 'wind_speed' then
        sVal := DS.Fields[i].FieldName + c_sd + '"' + FloatToStr(c_env_wpeed) + '"'
      else
        if DS.Fields[i].FieldName = 'wave_scale' then
        sVal := DS.Fields[i].FieldName + c_sd + '"' + FloatToStr(c_env_wscale) + '"'
      else
        if DS.Fields[i].FieldName = 'abovewater_fog_height' then
        sVal := DS.Fields[i].FieldName + c_sd + '"' + FloatToStr(c_env_fog_h) + '"'
      else
        sVal := DS.Fields[i].FieldName + c_sd + '"' + DS.Fields[i].AsString + '"';

      /// hardcode...field database kalo bisa jangan di rubah
      if i = 17 then begin
        sList.Add(sp2 + sVal);
        sList.Add(sp1 + c_end);
        sList.Add(sp1 + c_skybox);
      end
      else
        if i = 20 then begin
        sList.Add(sp2 + sVal);
        qSkybox.SQL.Clear;
        qSkybox.SQL.Add('select * from env_skybox where TIPE=' + IntToStr(c_env_theme));
        qSkybox.Open;
        sList.Add(sp2 + 'tex_up ="' + qSkybox.FieldByName('tex_up').AsString + c_kr);
        sList.Add(sp2 + 'tex_down ="' + qSkybox.FieldByName('tex_down').AsString + c_kr);
        sList.Add(sp2 + 'tex_left ="' + qSkybox.FieldByName('tex_left').AsString + c_kr);
        sList.Add(sp2 + 'tex_right ="' + qSkybox.FieldByName('tex_right').AsString + c_kr);
        sList.Add(sp2 + 'tex_front ="' + qSkybox.FieldByName('tex_front').AsString + c_kr);
        sList.Add(sp2 + 'tex_back ="' + qSkybox.FieldByName('tex_back').AsString + c_kr);
        qSkybox.Close;
        sList.Add(sp1 + c_end);
        sList.Add(sp1 + c_lighting);
      end
      else
        //if i = 36 then begin //BAWE: NIGHT_BODY ADD
        //if i = 37 then begin //BAWE: NIGHT_BODY ADD
        if i = 38 then begin //BAWE: GLOW_SHADER ADD
        sList.Add(sp2 + sVal);
        sList.Add(sp1 + c_end);
        sList.Add(sp1 + c_fog);
      end
      else
        sList.Add(sp2 + sVal);
    end;
    DS.Close;
  end;
  sList.Add(sp1 + c_end);
  sList.Add(ocean_head_end);

  try
       sList.SaveToFile(fileSaveName);
  except
       ShowMessage('Error save File : "'+fileSaveName+'"');
  end;


  sList.Free;
  qSkybox.Free;

  if bDebug then ShowMessage('End Generate Ocean XML Scenario');

end;

procedure GenerateDetailXMLScen(const scenarioID: integer; fileSaveName: string; bDebug: boolean);
const
  c_sd = ' = ';
  c_kr = '"';

  level_start = '<level>';
  level_end = '</level>';

  terrain_start = '<terrain';

  sbuil_start = '<static_buildings>';
  sbuil_end = '</static_buildings>';
  sbuil_com = '<building';

  sship_start = '<static_ships>';
  sship_end = '</static_ships>';
  sship_com = '<ship';

  sbuoy_start = '<static_buoys>';
  sbuoy_end = '</static_buoys>';
  sbuoy_com = '<buoy';

  c_end = '/>';

var
  i: integer;
  sName, sMesh, sTrans, sRot: string;
  sList: TStringList;

  c_env_peta, { 0 : Surabaya, 1 : Jakarta, 2 : Laut Lepas }
  c_env_building, { 0 : Active, 1 : Remove }
  c_env_static_ship, { 0 : Active, 1 : Remove }
  c_env_buoy { 0 : Active, 1 : Remove }: integer;

  qDetail: TZQuery;
begin
  if bDebug then ShowMessage('Start Generate Detail XML Scenario');

  qDetail := TZQuery.Create(DataModule1);
  qDetail.Connection := DataModule1.EmuConn;

  sList := TStringList.Create;

  with DataModule1 do begin
    DS.Close;
    DS.SQL.Clear;
    DS.SQL.Add('select * from sce_main where ID=:ID');
    DS.ParamByName('ID').AsInteger := scenarioID;
    DS.Open;

    if not DS.IsEmpty then begin
      c_env_peta := DS.FieldbyName('ENV_PETA').AsInteger;
      c_env_building := DS.FieldbyName('ENV_BUILDING').AsInteger;
      c_env_static_ship := DS.FieldbyName('ENV_SSHIPS').AsInteger;
      c_env_buoy := DS.FieldbyName('ENV_BUOY').AsInteger;
      DS.Close;
    end
    else
      ShowMessage('Generate Detail XML Scenario Error from ID ' + IntToStr(scenarioID));

    if c_env_peta = 2 { lepas pantai } then begin
      sList.Clear;
      sList.Add(level_start);
      {
      sList.Add(sp1 + terrain_start);
      sList.Add(sp1 + c_end);
      sList.Add(sp1 + sbuil_start);
      sList.Add(sp1 + sbuil_end);
      sList.Add(sp1 + sship_start);
      sList.Add(sp1 + sship_end);
      sList.Add(sp1 + sbuoy_start);
      sList.Add(sp1 + sbuoy_end);
      }
      sList.Add(level_end);
    end
    else begin
      sList.Clear;
      sList.Add(level_start);
      sList.Add(sp1 + terrain_start);

      qDetail.SQL.Clear;
      qDetail.SQL.Add('select * from env_terrain where TIPE=' + IntToStr(c_env_peta));
      qDetail.Open;

      sName := qDetail.FieldbyName('NAMA').AsString;
      sMesh := qDetail.FieldbyName('MESH').AsString;
      sTrans := FormatFloat('0.000000', qDetail.FieldbyName('TRANS_X').AsFloat) + ',' +
        FormatFloat('0.000000', qDetail.FieldbyName('TRANS_Y').AsFloat) + ',' +
        FormatFloat('0.000000', qDetail.FieldbyName('TRANS_Z').AsFloat);
      sRot := FormatFloat('0.000000', qDetail.FieldbyName('ROTATION').AsFloat) + ', 0.0, 0.0';

      sList.Add(sp2 + 'name ="' + sName + c_kr);
      sList.Add(sp2 + 'mesh ="' + sMesh + c_kr);
      sList.Add(sp2 + 'translation ="' + sTrans + c_kr);
      sList.Add(sp2 + 'rotation ="' + sRot + c_kr);
      sList.Add(sp1 + c_end);

      //// building
      if c_env_building = 0 { 0 : Active, 1 : Remove } then begin
        sList.Add(sp1 + sbuil_start);
        qDetail.SQL.Clear;
        qDetail.SQL.Add('select * from env_building where TIPE=' + IntToStr(c_env_peta));
        qDetail.Open;
        qDetail.First;
        for i := 1 to qDetail.RecordCount do begin
          sList.Add(sp2 + sbuil_com);
          sName := qDetail.FieldbyName('NAMA').AsString;
          sMesh := qDetail.FieldbyName('MESH').AsString;
          sTrans := FormatFloat('0.000000', qDetail.FieldbyName('TRANS_X').AsFloat) + ',' +
            FormatFloat('0.000000', qDetail.FieldbyName('TRANS_Y').AsFloat) + ',' +
            FormatFloat('0.000000', qDetail.FieldbyName('TRANS_Z').AsFloat);
          sRot := FormatFloat('0.000000', qDetail.FieldbyName('ROTATION').AsFloat) + ', 0.0, 0.0';

          sList.Add(sp3 + 'name ="' + sName + c_kr);
          sList.Add(sp3 + 'mesh ="' + sMesh + c_kr);
          sList.Add(sp3 + 'translation ="' + sTrans + c_kr);
          sList.Add(sp3 + 'rotation ="' + sRot + c_kr);
          sList.Add(sp2 + c_end);
          qDetail.Next;
        end;
        sList.Add(sp1 + sbuil_end);
      end;
      //// end building

      //// static ships
      if c_env_static_ship = 0 { 0 : Active, 1 : Remove } then begin
        sList.Add(sp1 + sship_start);
        qDetail.SQL.Clear;
        qDetail.SQL.Add('select * from env_ships where TIPE=' + IntToStr(c_env_peta));
        qDetail.Open;
        qDetail.First;
        for i := 1 to qDetail.RecordCount do begin
          sList.Add(sp2 + sship_com);
          sName := qDetail.FieldbyName('NAMA').AsString;
          sMesh := qDetail.FieldbyName('MESH').AsString;
          sTrans := FormatFloat('0.000000', qDetail.FieldbyName('TRANS_X').AsFloat) + ',' +
            FormatFloat('0.000000', qDetail.FieldbyName('TRANS_Y').AsFloat) + ',' +
            FormatFloat('0.000000', qDetail.FieldbyName('TRANS_Z').AsFloat);
          sRot := FormatFloat('0.000000', qDetail.FieldbyName('ROTATION').AsFloat) + ', 0.0, 0.0';

          sList.Add(sp3 + 'name ="' + sName + c_kr);
          sList.Add(sp3 + 'mesh ="' + sMesh + c_kr);
          sList.Add(sp3 + 'translation ="' + sTrans + c_kr);
          sList.Add(sp3 + 'rotation ="' + sRot + c_kr);
          sList.Add(sp2 + c_end);
          qDetail.Next;
        end;
        sList.Add(sp1 + sship_end);
      end;
      //// end static ships

      //// static buoy
      if c_env_buoy = 0 { 0 : Active, 1 : Remove } then begin
        sList.Add(sp1 + sbuoy_start);
        qDetail.SQL.Clear;
        qDetail.SQL.Add('select * from env_buoy where TIPE=' + IntToStr(c_env_peta));
        qDetail.Open;
        qDetail.First;
        for i := 1 to qDetail.RecordCount do begin
          sList.Add(sp2 + sbuoy_com);
          sName := qDetail.FieldbyName('NAMA').AsString;
          sMesh := qDetail.FieldbyName('MESH').AsString;
          sTrans := FormatFloat('0.000000', qDetail.FieldbyName('TRANS_X').AsFloat) + ',' +
            FormatFloat('0.000000', qDetail.FieldbyName('TRANS_Y').AsFloat) + ',' +
            FormatFloat('0.000000', qDetail.FieldbyName('TRANS_Z').AsFloat);
          sRot := FormatFloat('0.000000', qDetail.FieldbyName('ROTATION').AsFloat) + ', 0.0, 0.0';

          sList.Add(sp3 + 'name ="' + sName + c_kr);
          sList.Add(sp3 + 'mesh ="' + sMesh + c_kr);
          sList.Add(sp3 + 'translation ="' + sTrans + c_kr);
          sList.Add(sp3 + 'rotation ="' + sRot + c_kr);
          sList.Add(sp2 + c_end);
          qDetail.Next;
        end;
        sList.Add(sp1 + sbuoy_end);
      end;
      //// end static ships
      sList.Add(level_end);
    end;
  end;

      try
       sList.SaveToFile(fileSaveName);
    except
       ShowMessage('Error save File : "'+fileSaveName+'"');
    end;


  sList.Free;
  qDetail.Free;

  if bDebug then ShowMessage('End Generate Detail XML Scenario');

end;

end.

