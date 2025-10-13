unit uBaseSimulationObject;

  { Base Simulation System for RADAR simulation
    -------------------------------------------------------------------------
    -- unit       : uBaseSimulationObject                                  --
    -- description: Base Object for Simulation                             --
    -- level      : 0                                                      --
    -------------------------------------------------------------------------
    ..  First Created : 12 Mei 2005       ..
    ..  by            : andySu            ..
    ........................................
    ..  Release Version :                 ..
    ..  Release Date    :                 ..
    ........................................
  }

  { history
     .
     .
   }

interface

uses
  Classes, Windows, Graphics, uBaseDataType;

type

// === c o n t a i n e r ====================================================

  //== TSimulationContainer ====================================================
  //  Container berupa TThreadList untuk mewadahi object2 dalam simulasi
  //
  TSimulationContainer = class (TObject)
  private
    function getItemCount: integer;

  protected
    FListItem : TThreadList;

  public
    constructor Create;
    destructor Destroy; override;

    procedure AddObject(aObj: TObject); virtual;

    {remove from list and destroy the object}
    procedure RemoveObject(aObj: TObject); virtual;
    procedure RemoveObjectIndex(const Index: integer); virtual;
    procedure ClearObject(); virtual;

    procedure MarkMember_NeedFree(); virtual; abstract;
    procedure CleanUpObject(); virtual; abstract; // delete marked 'unused' object;

    {do not remove from list and return it}
    function getObject(const Index: integer): TObject;

    {remove from list and return it}
    function popObject(const Index: integer): TObject;

    procedure ReturnList;
    function  GetList: TList;

  public
    property ItemCount: integer read getItemCount;

  end;

  TSimulationClass = class;

  //== TViewContainer ==========================================================
  //
  TViewContainer = class (TSimulationContainer)
  public

    constructor Create;
    destructor Destroy; override;

    procedure MarkMember_NeedFree(); override;
    procedure CleanUpObject(); override;

    procedure ClearObjectByParent(aParent: TSimulationClass);

    procedure ConvertAllDataPosition(); virtual;
    procedure DrawAllView(aCnv: TCanvas); virtual;
  end;


  //== TObjectContainer =======================================================
  //
  TObjectContainer = class (TSimulationContainer)

  public
    constructor Create;
    destructor Destroy; override;

    procedure MarkMember_NeedFree(); override;
    procedure CleanUpObject(); override;

    procedure RunAllMemberObject(const aDeltaMs: double); virtual;
    procedure UpdateAllMemberObject(); virtual;

    function FindObjectByUid(const aUid: string): TSimulationClass;
    procedure GetUIDSnapshot(var ss: TStrings);
  end;

// === o b j e c t===========================================================



  // == TSimulationView ========================================================
  //
  TSimulationView = class (TObject)
  protected
    FParent       : TSimulationClass;
//    FKillMe       : boolean;

    FNeedToBeFree  : boolean;

  public
    CenterCoord   : TPoint;
    Visible       : boolean;
    Size          : Integer;
    Color         : TColor;
    Text          : string;

    constructor Create(aParent: TSimulationClass);
    destructor Destroy; override;

    procedure MarkAs_NeedToBeFree;

    procedure ConvertDataPosition(); virtual; abstract;

    procedure DrawView(aCnv: TCanvas); virtual; abstract;

  end;

  //== TSimulationObject =======================================================
  //
  TSimulationClass = class (TObject)
  protected
    FParent       : TObject;

    FUniqueID     : string;
    FLastExecute  : Longword;
    FLastDelay    : LongWord;

    FPosition     : t3DPoint;

    FRunInterleave      : tInterleave;
    FUpdateInterleave   : tInterleave;

    FNeedToBeFree  : boolean;

  public
    ViewContainer     : TViewContainer;
    ObjectContainer   : TObjectContainer;

    Enabled           : boolean;
    Selected          : Boolean;

    isRulerStart      : boolean;
    isRulerEnd        : boolean;

    constructor Create;
    destructor Destroy; override;

    procedure MarkAs_NeedToBeFree;
    procedure DeleteAllChildren;


    procedure Update;    virtual;            // procedure ini akan dijalankan oleh thread;
    procedure Run(const aDeltaMs: double);    virtual;  // procedure ini akan dijalankan oleh thread;

  public
    property PositionX : double read FPosition.X write FPosition.X;
    property PositionY : double read FPosition.Y write FPosition.Y;
    property PositionZ : double read FPosition.Z write FPosition.Z;

    property UniqueID: string read FUniqueID write FUniqueID;

  end;

  procedure ConvertMembersViewsPosition(aObjList: TObjectContainer);
  procedure DrawMembersView(aObjList: TObjectContainer; aCnv: TCanvas);

implementation


//==============================================================================
{ TSimulationContainer }

  constructor TSimulationContainer.Create;
  begin
    FListItem := TThreadList.Create;

  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  destructor TSimulationContainer.Destroy;
  begin
    FListItem.Free;
    FListItem := nil;

    inherited;
  end;

//- TSimulationContainer private method -----------------------------------------
  function TSimulationContainer.getList: TList;
  begin
    result := FListItem.LockList;

  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TSimulationContainer.ReturnList;
  begin
    FListItem.UnlockList;

  end;

  //- TSimulationContainer public method -----------------------------------------
  procedure TSimulationContainer.AddObject(aObj: TObject);
  begin
    with FListItem.LockList do
      try
        Add(aObj);
      finally
        FListItem.UnlockList;
      end;
  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TSimulationContainer.RemoveObject(aObj: TObject);
  begin
    with FListItem.LockList do
      try
        Remove(aObj);
        aObj.Free;
      finally
        FListItem.UnlockList;
      end;
  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TSimulationContainer.RemoveObjectIndex(const Index: integer);
  var obj : TObject;
  begin
    with FListItem.LockList do
      try
        if (Index >= 0) and (Index < Count) then begin
          obj := Items[Index];
          Delete(Index);
          obj.Free;
        end;
      finally
        FListItem.UnlockList;
      end;
  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TSimulationContainer.ClearObject();
  var i   : integer;
      obj : TObject;
  begin
    with FListItem.LockList do
      try
        for i:= Count-1 downto 0 do begin
           obj := Items[i];
           obj.Free;
        end;
        Clear;
      finally
        FListItem.UnlockList;
      end;
  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  function TSimulationContainer.popObject(const Index: integer): TObject;
  begin
    result := nil;
    with FListItem.LockList do
      try
        if (Index >= 0) and (Index < Count) then begin
          result := Items[Index];
          Delete(Index);
        end;
      finally
        FListItem.UnlockList;
      end;
  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  function TSimulationContainer.getObject(const Index: integer): TObject;
  begin
    result := nil;
    with FListItem.LockList do
      try
        if (Index >= 0) and (Index < Count) then begin
          result := Items[Index];
        end;
      finally
        FListItem.UnlockList;
      end;
  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  function TSimulationContainer.getItemCount: integer;
  begin
    Result := FListItem.LockList.Count;
    FListItem.UnlockList;
  end;


  //==============================================================================
  { TViewContainer }

  constructor TViewContainer.Create;
  begin
    inherited;

  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  destructor TViewContainer.Destroy;
  begin

    inherited;
  end;

  //- TViewContainer public method -----------------------------------------------
  procedure TViewContainer.ConvertAllDataPosition();
  var i   : integer;
      View: TSimulationView;
  begin

    with FListItem.LockList do
      try
        for i := 0 to Count-1 do begin
          View := TSimulationView(Items[i]);

          View.ConvertDataPosition();
        end;
      finally
        FListItem.UnlockList;
      end;
  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TViewContainer.DrawAllView(aCnv: TCanvas);
  var i   : integer;
      View: TSimulationView;
  begin

    with FListItem.LockList do
      try
        if Count > 0 then
        for i := 0 to Count-1 do begin
          View := TSimulationView(Items[i]);
          if View.Visible then
             View.DrawView(aCnv);
        end;
      finally
        FListItem.UnlockList;
      end;
  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TViewContainer.MarkMember_NeedFree;
  {Contain List Structure}
  var i   : integer;
      view : TSimulationView;
  begin
    with FListItem.LockList do
      try
        for i := Count-1 downto 0 do begin
          view := TSimulationView(Items[i]);
          view.MarkAs_NeedToBeFree;
        end
      finally
        FListItem.UnlockList;
      end;
  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TViewContainer.CleanUpObject;
  {Contain List Structure}
  var i   : integer;
      view : TSimulationView;
  begin
    with FListItem.LockList do
      try
        for i := Count-1 downto 0 do begin
          view := TSimulationView(Items[i]);
          if view.FNeedToBeFree then begin
              view.Free;
              Delete(i);
          end;
        end;
        pack;

      finally
        FListItem.UnlockList;
      end;
  end;

  procedure TViewContainer.ClearObjectByParent(aParent: TSimulationClass);
  var i   : integer;
      view : TSimulationView;
  begin
    with FListItem.LockList do
      try
        for i := Count-1 downto 0 do begin
          view := TSimulationView(Items[i]);
          if view.FParent = aParent then begin
             view.Free;
             Delete(i);
          end;
        end
      finally
        FListItem.UnlockList;
      end;
  end;


  //==============================================================================
  { TObjectContainer }

  constructor TObjectContainer.Create;
  begin
    inherited;

  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  destructor TObjectContainer.Destroy;
  begin

    inherited;
  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TObjectContainer.RunAllMemberObject(const aDeltaMs: double);
  var i   : integer;
      obj : TSimulationClass;
  begin
    with FListItem.LockList do
      try
        for i := 0 to Count-1 do begin
          obj := TSimulationClass(Items[i]);
          if obj.Enabled then
            obj.Run(aDeltaMs);
        end
      finally
        FListItem.UnlockList;
      end;

  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TObjectContainer.UpdateAllMemberObject;
  var i   : integer;
      obj : TSimulationClass;
  begin
    with FListItem.LockList do
      try
        for i := 0 to Count-1 do begin
          obj := TSimulationClass(Items[i]);
          if obj.Enabled then
               obj.Update
        end
      finally
        FListItem.UnlockList;
      end;

  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TObjectContainer.MarkMember_NeedFree;
  var i   : integer;
      obj : TSimulationClass;
  begin
    with FListItem.LockList do
      try
        for i := Count-1 downto 0 do begin
          obj := TSimulationClass(Items[i]);
          obj.MarkAs_NeedToBeFree;
        end
      finally
        FListItem.UnlockList;
      end;
  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(* classic clean up
  procedure TObjectContainer.CleanUpObject;
  var i   : integer;
      obj : TSimulationClass;
  begin
    with FListItem.LockList do
      try
        for i := Count-1 downto 0 do begin
          obj := TSimulationClass(Items[i]);
          if obj.FNeedToBeFree then  begin
              obj.DeleteAllChildren;
               Delete(i);
              obj.Free;
          end;

        end;
        pack;
      finally
        FListItem.UnlockList;
      end;

  end;
*)
  // advance clean up methode;
  procedure TObjectContainer.CleanUpObject;
  var i   : integer;
      obj : TSimulationClass;
      NewList : TThreadList;
  begin
    newList := TThreadList.Create;
    with FListItem.LockList do
      try
        for i := 0 to Count-1 do begin
          obj := TSimulationClass(Items[i]);
          if obj.FNeedToBeFree then begin
              obj.DeleteAllChildren;
              obj.Free;
          end
          else begin
            newList.Add(obj);
          end

        end;
        Clear;
      finally
        FListItem.UnlockList;
        FListItem.Free;
      end;

    FListItem := newList;
  end;

  //- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  function TObjectContainer.FindObjectByUid(const aUid: string): TSimulationClass;
  var i   : integer;
      obj : TSimulationClass;
      found : boolean;
  begin
    result := nil;
    obj := nil;
    with FListItem.LockList do
      try
        i := 0;
        found  := false;
        while not found and (i<Count) do begin
          obj := TSimulationClass(Items[i]);
          found :=  aUid = obj.FUniqueID;

          inc(i);
        end;
      finally
        FListItem.UnlockList;
      end;
    if found then result := obj;

  end;
  //- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TObjectContainer.GetUIDSnapshot(var ss: TStrings);
  var i   : integer;
      obj : TSimulationClass;
  begin
    if assigned(ss) then
      ss.Clear
    else
      ss := TStringList.Create;

    with FListItem.LockList do
      try
        for i := 0 to Count-1 do begin
          obj := TSimulationClass(Items[i]);
          ss.Add(obj.UniqueID);
        end;
      finally
        FListItem.UnlockList;
      end;

    TStringList(ss).Sort;

  end;
  //==============================================================================
  //==============================================================================

  { TSimulationView }

  constructor TSimulationView.Create;
  begin
    FNeedToBeFree := FALSE;

    FParent := aParent;
  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  destructor TSimulationView.Destroy;
  begin

    inherited;
  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TSimulationView.MarkAs_NeedToBeFree;
  begin
    FNeedToBeFree := TRUE;

  end;

  //==============================================================================

  { TSimulationClass }

  constructor TSimulationClass.Create;
  begin
    FNeedToBeFree := FALSE;

    ViewContainer   := TViewContainer.Create;
    ObjectContainer := TObjectContainer.Create;

    FParent := nil;

    FRunInterleave.Counter := 0;
    FRunInterleave.Cycle   := 0;

    FUpdateInterleave.Counter := 0;
    FUpdateInterleave.Cycle   := 0;

  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  destructor TSimulationClass.Destroy;
  begin
    FParent := nil;

    ObjectContainer.Free;
    ViewContainer.Free;

    inherited;
  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TSimulationClass.MarkAs_NeedToBeFree;
  {Contain Tree Structure.
  phase 1 of garbage collector}
  begin
    FNeedToBeFree := TRUE;

    ViewContainer.MarkMember_NeedFree;
    ObjectContainer.MarkMember_NeedFree;
  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TSimulationClass.DeleteAllChildren;
  begin
  //  ViewContainer.CleanUpObject;
    ObjectContainer.CleanUpObject;
  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TSimulationClass.Update;
  begin
   // ini diisii procedure yg berhubungan dengan object lain, atau sebelum move
    if FUpdateInterleave.Cycle > 0 then begin
      FUpdateInterleave.Counter := (FUpdateInterleave.Counter + 1);
      FUpdateInterleave.Counter := FUpdateInterleave.Counter mod FUpdateInterleave.Cycle;
    end;

  end;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  procedure TSimulationClass.Run(const aDeltaMs: double);
  begin
    // ini diisi move.

    if FRunInterleave.Cycle > 0 then begin
      FRunInterleave.Counter := (FRunInterleave.Counter + 1);
      FRunInterleave.Counter := FRunInterleave.Counter mod FRunInterleave.Cycle;
    end;

  end;

  procedure ConvertMembersViewsPosition(aObjList: TObjectContainer);
  var i: integer;
      list: TList;
      obj : TSimulationClass;
  begin

    //-> convert all member's  view container.
    List := aObjList.GetList;
    for i := 0 to List.Count-1 do begin
      obj := List[i];
      obj.ViewContainer.ConvertAllDataPosition;
     end;

    aObjList.ReturnList;
  end;

  procedure DrawMembersView(aObjList: TObjectContainer; aCnv: TCanvas);
  var i: integer;
      list: TList;
      obj : TSimulationClass;
  begin

    //-> convert all member's  view container.
    List := aObjList.GetList;
    for i := 0 to List.Count-1 do begin
      obj := List[i];
      obj.ViewContainer.DrawAllView(aCnv);
     end;

    aObjList.ReturnList;
  end;



end.

