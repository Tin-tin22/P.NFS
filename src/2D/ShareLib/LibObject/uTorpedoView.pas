unit uTorpedoView;

interface


uses
   MapXLib_TLB ,Windows, Graphics,

   uBaseDatatype, uBaseSimulationObject, uMapXSim ;


type


//==============================================================================
    TTorpedoView = class(TSimViewOnMapX)
    private
      CharSymbol: Char;

    public
      ptHit    : t2DComboPoint;
      ptMaxWire: t2DComboPoint;
      ptMaxBatt: t2DComboPoint;
      TubeInfo: string;

      constructor CreateOnMapX(aParent: TSimulationClass; aMap: TMap); override;
      procedure ConvertDataPosition(); override;
      procedure DrawView(aCnv: TCanvas); override;
    end;

implementation


uses
  uBaseFunction, uBaseConstan;

{ TTorpedoView }

constructor TTorpedoView.CreateOnMapX(aParent: TSimulationClass;
  aMap: TMap);
begin
  inherited;

  ptHit.Mx.X := FParent.PositionX;
  ptHit.Mx.Y := FParent.PositionY;
  ptHit.Sc := Convert_MapToScreen(FMap, ptHit.Mx);

  CharSymbol := C_Symbol_Char[i_PHP_torpedo];
end;

procedure TTorpedoView.ConvertDataPosition;
begin
  inherited;

  ptHit.Sc    := Convert_MapToScreen(FMap, ptHit.Mx);
  ptMaxWire.Sc    := Convert_MapToScreen(FMap, ptMaxWire.Mx);
  ptMaxBatt.Sc    := Convert_MapToScreen(FMap, ptMaxBatt.Mx);
end;

procedure TTorpedoView.DrawView(aCnv: TCanvas);
var sz : TSize;
begin
  inherited;

  if not Visible then exit;

  aCnv.Pen.Color := C_defColor;
  aCnv.MoveTo(CenterCoord.X, CenterCoord.Y); // torpedo origin
  aCnv.LineTo(ptHit.Sc.X, ptHit.Sc.Y);
//  r := ptToRect(CenterCoord, 4);
//  aCnv.Ellipse(r); // target position

  aCnv.Pen.Color := C_defColor;
  aCnv.LineTo(ptMaxWire.Sc.X, ptMaxWire.Sc.Y);


  aCnv.Pen.Color := C_defColor;
  aCnv.LineTo(ptMaxBatt.Sc.X, ptMaxBatt.Sc.Y);

  SetBkMode(aCnv.Handle, TRANSPARENT);
  with aCnv do begin
    Font.Name  :=  'TDCCursor';
    Font.Size  :=  12;
    Font.Color :=  C_defColor;
    sz :=  TextExtent(CharSymbol);
    sz.cx := sz.cx shr 1;
    sz.cy := sz.cy shr 1;
    //aligned center
    TextOut(ptHit.Sc.X - sz.cx,
            ptHit.Sc.Y - sz.cy,
            CharSymbol);

    Font.Name  :=  'Verdana';
    Font.Size  :=  8;
    TextOut(ptHit.Sc.X + sz.cx + 4,
            ptHit.Sc.Y - sz.cy  , TubeInfo);


    Font.Name  :=  'TDCIdent';
    Font.Size  :=  8;
    sz :=  TextExtent(ID_Max_Wire);
    TextOut(ptMaxWire.Sc.X - sz.cx shr 1, ptMaxWire.Sc.Y - sz.cy shr 1
             , ID_Max_Wire);

    sz :=  TextExtent(ID_Max_Batt);
    TextOut(ptMaxBatt.Sc.X - sz.cx shr 1, ptMaxBatt.Sc.Y  - sz.cy shr 1
             , ID_Max_Batt);
  end;
end;

end.
