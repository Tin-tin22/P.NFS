unit uTorpedoView;

interface


uses
   Windows, Graphics, MapXLib_TLB ,

   uBaseDatatype, uBaseSimulationObject, uMapXSim ;


type


//==============================================================================
    TTorpedoView = class(TSimViewOnMapX)
    private
      CharSymbol: Char;

    public
      ptHit     : t2DComboPoint;
      ptMaxWire : t2DComboPoint;
      ptMaxBatt : t2DComboPoint;
      ptSafeDist: t2DComboPoint;
      ptEndis   : t2DComboPoint;
      TubeInfo: string;

      TempcenterX   : Longint;
      TempcenterY   : Longint;
      Status        : Integer;
      visiblePHP    : Boolean;
      Show_Endist   : Boolean;

      Smbl_Endis    : double;
      Smbl_MaxWire  : double;
      Smbl_MaxBat   : double;

      constructor CreateOnMapX(aParent: TSimulationClass; aMap: TMap); override;
      procedure ConvertDataPosition(); override;
      procedure DrawView(aCnv: TCanvas); override;
      procedure SetRange_Symbol(Val_Endis : double; Val_MaxWire : double; Val_MaxBat : double);
      destructor Destroy; override;

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
  Show_Endist := true;
end;

procedure TTorpedoView.ConvertDataPosition;
begin
  inherited;

  ptHit.Sc      := Convert_MapToScreen(FMap, ptHit.Mx);
  ptMaxWire.Sc  := Convert_MapToScreen(FMap, ptMaxWire.Mx);
  ptMaxBatt.Sc  := Convert_MapToScreen(FMap, ptMaxBatt.Mx);
  ptEndis.Sc    := Convert_MapToScreen(FMap, ptEndis.Mx);
end;

destructor TTorpedoView.Destroy;
begin

  inherited;
end;

procedure TTorpedoView.DrawView(aCnv: TCanvas);
var sz : TSize;
begin
  inherited;

  if not Visible then
    exit;

  if (Status = 2) or (Status = 3) then
  begin
    CenterCoord.X := TempcenterX;
    CenterCoord.Y := TempcenterY;
  end
  else
  begin
    TempcenterX := CenterCoord.X;
    TempcenterY := CenterCoord.Y;
  end;

  aCnv.Pen.Color := C_defColor;
  aCnv.MoveTo(CenterCoord.X, CenterCoord.Y);    {Torpedo Origin}
  aCnv.LineTo(ptMaxBatt.Sc.X, ptMaxBatt.Sc.Y);  {Titik terakhir line}

  SetBkMode(aCnv.Handle, TRANSPARENT);
  with aCnv do begin

    if visiblePHP then
    begin
      Font.Name  :=  'TDCCursor';
      Font.Size  :=  12;
      Font.Color :=  C_defColor;

      sz :=  TextExtent(CharSymbol);
      sz.cx := sz.cx shr 1;
      sz.cy := sz.cy shr 1;
      TextOut(ptHit.Sc.X - sz.cx, ptHit.Sc.Y - sz.cy, CharSymbol);

      Font.Name  :=  'Verdana';
      Font.Size  :=  8;
      TextOut(ptHit.Sc.X + sz.cx + 4, ptHit.Sc.Y - sz.cy  , TubeInfo);
    end
    else
    begin
      sz        :=  TextExtent(ID_Max_Batt);
      Font.Name :=  'Verdana';
      Font.Size :=  8;
      TextOut(ptMaxBatt.Sc.X - sz.cx shr 1 - 8, ptMaxBatt.Sc.Y  - sz.cy shr 1 + 8, TubeInfo);
    end;

    sz          :=  TextExtent(ID_Max_Wire);
    Font.Name   :=  'TDCIdent';
    Font.Size   :=  8;
    TextOut(ptMaxWire.Sc.X - sz.cx shr 1, ptMaxWire.Sc.Y - sz.cy shr 1, ID_Max_Wire);

    sz          :=  TextExtent(ID_Max_Batt);
    TextOut(ptMaxBatt.Sc.X - sz.cx shr 1, ptMaxBatt.Sc.Y  - sz.cy shr 1, ID_Max_Batt);

    if Show_Endist then
    begin
      sz        :=  TextExtent(ID_Endis);
      TextOut(ptEndis.Sc.X - sz.cx shr 1, ptEndis.Sc.Y  - sz.cy shr 1, ID_Endis);
    end;
  end;
end;

procedure TTorpedoView.SetRange_Symbol(Val_Endis, Val_MaxWire,
  Val_MaxBat: double);
begin
  Smbl_Endis    := Val_Endis * C_Yard_To_NauticalMiles * C_NauticalMile_To_Degree;
  Smbl_MaxWire  := Val_MaxWire * C_Yard_To_NauticalMiles * C_NauticalMile_To_Degree;
  Smbl_MaxBat   := Val_MaxBat * C_Yard_To_NauticalMiles * C_NauticalMile_To_Degree;
end;
end.
