unit uBaseGraphicObjects;

(*
   deskripsi:
     class dasar untuk pembuatan object yg akan digambar di canvas;

   -------------------------
   started    : 30 Juli 2007
   created by : Andy Sucipto.
*)


interface

uses
  Classes, Windows, Graphics, Dialogs;

type

  //==========================================================================//

  //==========================================================================//
  { TCanvasObjects
    punya Area berupa rectangle
    punya property left, top, width, heigh, centerx, centery
  }

  TCanvasObject = class
  protected
    FBoundRect   : TRect;
    FCenter      : TPoint;

    FWidth, FHalfWidth: integer;
    FHeight, FHalfHeight: integer;

    procedure SetLeftTop(const i: integer; const aXY: integer); virtual;
    procedure SetSizeXY(const i: integer; const aSzXY: integer);  virtual;

    procedure Draw(aCnv: TCanvas); virtual; abstract;
  public

    constructor Create;
    destructor Destroy; override;

    property CenterX : integer index 1 read FCenter.X write SetSizeXY;
    property CenterY : integer index 2 read FCenter.Y write SetSizeXY;

    property Width: integer index 3 read FWidth write SetSizeXY;
    property Height: integer index 4 read FHeight write SetSizeXY;

    property Left: integer index 1 read FBoundRect.Left write SetLeftTop;
    property Top: integer index 2 read FBoundRect.Top write SetLeftTop;

  end;

  //======================================================================== //
  TBMPObject = class(TCanvasObject)
  protected
    FBmp         : TBitmap;

    procedure SetSizeXY(const i: integer; const aSzXY: integer);  override;

  public
    procedure Draw(aCnv: TCanvas); override;

    constructor Create;
    destructor Destroy; override;

  end;


  
  //======================================================================== //
  { export global function }


implementation

uses
  Math, Types, SysUtils, uBaseGraphicProc;


//===========================================================================
{ TCanvasObject }

constructor TCanvasObject.Create;
begin
  inherited;

end;

destructor TCanvasObject.Destroy;
begin

  inherited;
end;

procedure TCanvasObject.SetLeftTop(const i, aXY: integer);
begin
  case i of
  1 : begin // Set left
        FBoundRect.Left := aXY;
        FBoundRect.Right:= aXY + FWidth;
        FCenter.X := FBoundRect.Left + FHalfWidth;
    end;
  2 : begin // SetTop
        FBoundRect.Top   := aXY;
        FBoundRect.Right := aXY + FHeight;
        FCenter.Y := FBoundRect.Top + FHalfHeight;
    end;
  end

end;

procedure TCanvasObject.SetSizeXY(const i: integer; const aSzXY: integer);
begin
  case i of
  1 : begin // set center X
        FCenter.X := aSzXY;
    end;
  2 : begin // Set Center Y
        FCenter.Y := aSzXY;
    end;
  3 : begin // Set Width
        FWidth   := aSzXY;
        FHalfWidth := aSzXY shr 1;
        FCenter.X :=  FBoundRect.Left + FHalfWidth;
    end;
  4 : begin // Set Height
        FHeight   := aSzXY;
        FHalfHeight := aSzXY shr 1;
        FCenter.Y :=  FBoundRect.Top + FHalfHeight;
    end;
  end;

  if (i mod 2) = 1 then begin    //
    FBoundRect.TopLeft.X     := FCenter.X - FHalfWidth;
    FBoundRect.BottomRight.X := FCenter.X + FHalfWidth;
  end
  else begin
    FBoundRect.TopLeft.Y     := FCenter.Y - FHalfHeight;
    FBoundRect.BottomRight.Y := FCenter.Y + FHalfHeight;
  end;

end;

//==============================================================================
{ TBMPObject }

constructor TBMPObject.Create;
begin
  inherited;

  FBmp := TBitmap.Create;
  FBmp.PixelFormat := C_DefaultPixelFormat; //default;

end;

destructor TBMPObject.Destroy;
begin
  DestroyBitmap(FBMP);

  inherited;
end;

procedure TBMPObject.Draw(aCnv: TCanvas);
begin
  inherited;

end;

procedure TBMPObject.SetSizeXY(const i, aSzXY: integer);
begin
  inherited;

  case i of
  3 : begin // Set Width
        FBmp.Width := aSzXY;
    end;
  4 : begin // Set Height
        FBmp.Height := aSzXY;
    end;
  end;

end;

end.
