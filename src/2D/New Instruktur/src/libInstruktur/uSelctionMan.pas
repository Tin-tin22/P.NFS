unit uSelctionMan;

interface

uses

  windows, Classes, Graphics, uInstrukturObjects, uInstrukturViews,
  uBaseDataType;

  type

    TSelectedObject = class (TRectView)
    protected
      FStartPos: t2dpoint;
      FptStart : TPoint;
    public
      simObj : TInsObject;


    end;

    TSelectionMgr = class
    private
      Flist : TStringList;
      FSel  : TSelectedObject;
      FDOrgRect, FDSelRect : TDoubleRect;

      function getCount: integer;
      function getItems(ix: integer): TInsObject;

    public
      RectOrg, RectSelect: TRect;

      constructor Create;
      destructor Destroy; override;

      procedure ClearSelection;

      procedure AddToSelection(var o: TInsObject);
      procedure RemoveFromSelection(var o: TInsObject);

      procedure DrawSelection(aCvs: TCanvas);

      procedure BeginMove;
      procedure MoveOffset(const dx, dy: double);
      procedure EndMove;

      property Count: integer read getCount;
      property Items[ix: integer]: TInsObject read getItems;
    end;



implementation

//uses


{ TSelectionMgr }
constructor TSelectionMgr.Create;
begin
  FList := TStringList.Create;
end;

destructor TSelectionMgr.Destroy;
begin
  FList.Clear;
  FList.Free;
  inherited;
end;

procedure TSelectionMgr.AddToSelection(var o: TInsObject);
begin
  if FList.IndexOf(o.UniqueID) >= 0 then exit;

  FSel := TSelectedObject.Create;
  fSel.simObj := o;

  FList.AddObject(o.UniqueID, fSel);
end;

procedure TSelectionMgr.ClearSelection;
begin
  Flist.Clear;
end;


procedure TSelectionMgr.RemoveFromSelection(var o: TInsObject);
var i: integer;
begin
  i := FList.IndexOf(o.UniqueID);
  if i >= 0 then
  Flist.Delete(i);
end;

procedure TSelectionMgr.DrawSelection(aCvs: TCanvas);
begin

end;

function TSelectionMgr.getCount: integer;
begin
  result := FList.Count;
end;

procedure TSelectionMgr.BeginMove;
var i: integer;
begin
  for i := 0 to FList.Count-1 do begin
    fSel := TSelectedObject(FList.Objects[i]);
    fsel.FStartPos.X := fSel.simObj.PositionX;
    fsel.FStartPos.Y := fSel.simObj.PositionY;
    fsel.FptStart.X  := fSel.simObj.VSymbol.CenterCoord.X;
    fsel.FptStart.Y  := fSel.simObj.VSymbol.CenterCoord.Y;
  end;
  FDOrgRect := FDSelRect;
  RectOrg  := RectSelect;
end;

procedure TSelectionMgr.MoveOffset(const dx, dy: double);
var i: integer;
begin
  FDSelRect.Left   := FDOrgRect.Left    + dx;
  FDSelRect.Right  := FDOrgRect.Right   + dx;
  FDSelRect.Top    := FDOrgRect.Top     + dy;
  FDSelRect.Bottom := FDOrgRect.Bottom  + dy;

  for i := 0 to FList.Count-1 do begin
    fSel := TSelectedObject(FList.Objects[i]);
    FSel.simObj.AllowUpdate := false;
    fSel.simObj.MoveTo(fsel.FStartPos.X + dx, fsel.FStartPos.Y + dy);
  end;
end;

procedure TSelectionMgr.EndMove;
begin

end;

function TSelectionMgr.getItems(ix: integer): TInsObject;
begin
  fSel := TSelectedObject(FList.Objects[ix]);
  result := fSel.simObj;

end;

end.

